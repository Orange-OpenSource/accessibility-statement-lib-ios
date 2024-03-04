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
    private var insideResults = false


    func parseXML(fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "xml") {
            if let xmlParser = XMLParser(contentsOf: url) {
                xmlParser.delegate = self
                xmlParser.parse()
            } else {
                print("Error when creating the XML parser.")
            }
        } else {
            print("XML file not found in the bundle.")
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
            if elementName == "results" {
                insideResults = true
            }
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if insideResults && currentElement == "conformity" {
            // If inside <results> and the current element is "conformity"
            self.declarations.conformity += data
        }

        if (!data.isEmpty && currentElement != "conformity") {
            // If data is not empty and current element is not "conformity"
            switch self.currentElement {
            case "title_app":
                self.declarations.title += " \(data)"
            case "audit_date":
                self.declarations.auditDate += " \(data)"
                self.declarations.auditDate = self.dateToFrench(inputDate: self.declarations.auditDate)
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
            self.declarations.identityAdresse = "Siège sociale : 111, quai du Président Rooevelt, 91130 Issy-les-Moulieaux"
            self.declarations.referentialName = "WCAG " + declarations.referentialVersion + " " + declarations.referentialLevel
        }
    }


    func parserDidEndDocument(_ parser: XMLParser) {
        print("Analyse XML terminée.")
        insideResults = false
        declarationDataUpdated()
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Erreur d'analyse XML: \(parseError.localizedDescription)")

    }

    func declarationDataUpdated() {
        NotificationCenter.default.post(name: Notification.Name("DeclarationDataDidUpdate"), object: nil, userInfo: ["declarationData": declarations])
    }
    
    public func dateToFrench(inputDate: String) -> String {
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
