/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

import Foundation

class DeclarationDataParser: NSObject, XMLParserDelegate {
    var declarations: Declaration = Declaration()
    private var currentElement = ""
    private var currentData = ""
    var foundTotalResult: Bool = false

    func parseXML(fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "xml") {
            if let xmlParser = XMLParser(contentsOf: url) {
                xmlParser.delegate = self
                xmlParser.parse()
            } else {
                Log.error("Error when creating the XML parser.")
            }
        } else {
            Log.error("XML file not found in the bundle.")
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        if elementName == "result" {
            if let type = attributeDict["type"], type == "total" {
                foundTotalResult = true
            } else {
                foundTotalResult = false
            }
        }
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            switch self.currentElement {
            case "title_app":
                self.declarations.title += " \(data)"
            case "audit_date":
                self.declarations.auditDate = localizedDates(inputDate: " \(data)")
            case "conformity":
                if foundTotalResult {
                    if let conformity = Float(string) {
                        self.declarations.conformityAverage = CGFloat(conformity / 100)
                        self.declarations.conformityAverageDisplay = String(Int(conformity.rounded()))
                    }
                }
            case "technology":
                self.declarations.technologies += "\(data)"
            case "version":
                self.declarations.referentialVersion += " \(data)"
            case "level":
                self.declarations.referentialLevel += data
            default:
                break
            }
            
            self.declarations.identityName = "Orange SA"
            self.declarations.identityAdresse = "Siège social : 111, quai du Président Roosevelt, CS 70222, 91130 Issy-les-Moulineaux CEDEX"
            self.declarations.referentialName = "WCAG " + declarations.referentialVersion + " " + declarations.referentialLevel
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        Log.log("XML statement parsing completed.")
        declarationDataUpdated()
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        Log.error("Error occured while processing XML: '\(parseError.localizedDescription)'")

    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "result" {
            foundTotalResult = false
            currentData = ""
        }
    }

    func declarationDataUpdated() {
        NotificationCenter.default.post(name: Notification.Name("DeclarationDataDidUpdate"), object: nil, userInfo: ["declarationData": declarations])
    }
    
    public func localizedDates(inputDate: String) -> (toDisplay: String, toVocalize: String)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var languageString = ""
        if let language = Bundle.main.preferredLocalizations.first {
            let languageAsNSString = language as NSString
            languageString = (languageAsNSString as String)
        } else {
            languageString = "en_US"
        }

        // TODO: Use Cache to store DateFormatter and results to prevent costly computing of such values
        guard let date = dateFormatter.date(from: inputDate) else { return nil }
        dateFormatter.locale = Locale(identifier: languageString)

        let dateFormatForDisplay = DateFormatter.dateFormat(fromTemplate: "dd-MMM-yyyy", options: 0, locale: dateFormatter.locale)
        dateFormatter.dateFormat = dateFormatForDisplay
        let localDate = dateFormatter.string(from: date)

        let dateFormatForVocalization = DateFormatter.dateFormat(fromTemplate: "dd-MMMM-yyyy", options: 0, locale: dateFormatter.locale)
        dateFormatter.dateFormat = dateFormatForVocalization
        let toVocalize = dateFormatter.string(from: date)

        return (toDisplay: localDate, toVocalize: toVocalize)
    }
}
