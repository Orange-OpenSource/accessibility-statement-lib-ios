// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation

class DeclarationDataParser: NSObject, XMLParserDelegate {
    var declarations: Declaration = .init()
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

    func parser(_: XMLParser, didStartElement elementName: String, namespaceURI _: String?, qualifiedName _: String?, attributes attributeDict: [String: String]) {
        currentElement = elementName
        if elementName == "result" {
            if let type = attributeDict["type"], type == "total" {
                foundTotalResult = true
            } else {
                foundTotalResult = false
            }
        }
    }

    func parser(_: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if !data.isEmpty {
            switch currentElement {
            case "title_app":
                declarations.title += " \(data)"
            case "audit_date":
                declarations.auditDate += " \(data)"
                declarations.auditDate = dateToFrench(inputDate: declarations.auditDate)
            case "conformity":
                if foundTotalResult {
                    if let conformity = Float(string) {
                        declarations.conformityAverage = CGFloat(conformity / 100)
                        declarations.conformityAverageDisplay = String(Int(conformity.rounded()))
                    }
                }
            case "technology":
                declarations.technologies += "\(data)"
            case "version":
                declarations.referentialVersion += " \(data)"
            case "level":
                declarations.referentialLevel += data
            default:
                break
            }

            declarations.identityName = "Orange SA"
            declarations.identityAdresse = "Siège social : 111, quai du Président Roosevelt, CS 70222, 91130 Issy-les-Moulineaux CEDEX"
            declarations.referentialName = "WCAG " + declarations.referentialVersion + " " + declarations.referentialLevel
        }
    }

    func parserDidEndDocument(_: XMLParser) {
        Log.log("XML statement parsing completed.")
        declarationDataUpdated()
    }

    func parser(_: XMLParser, parseErrorOccurred parseError: Error) {
        Log.error("Error occured while processing XML: '\(parseError.localizedDescription)'")
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
        if elementName == "result" {
            foundTotalResult = false
            currentData = ""
        }
    }

    func declarationDataUpdated() {
        NotificationCenter.default.post(name: Notification.Name("DeclarationDataDidUpdate"), object: nil, userInfo: ["declarationData": declarations])
    }

    func dateToFrench(inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let language = Bundle.main.preferredLocalizations.first! as NSString
        let languageString = (language as String)

        guard let date = dateFormatter.date(from: inputDate) else { return "" }
        dateFormatter.locale = Locale(identifier: languageString)
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd-MMM-yyyy", options: 0, locale: dateFormatter.locale)
        let LocalDate = dateFormatter.string(from: date)
        return LocalDate
    }
}
