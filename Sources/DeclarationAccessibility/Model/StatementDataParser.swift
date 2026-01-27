// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import Foundation

/// XML parser which will process an accessibility statement file in XML format to then populate a Swift object ``Statement``
final class StatementDataParser: NSObject, XMLParserDelegate {

    private var currentElement: String

    var statement: Statement
    var foundTotalResult: Bool

    override init() {
        currentElement = ""
        statement = Statement()
        foundTotalResult = false
        super.init()
    }

    deinit {}

    // MARK: - XML processing

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

    // TODO: Refactor the parsing
    func parser(_: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if !data.isEmpty {
            switch currentElement {
            case "title_app":
                statement.title += " \(data)"
            case "audit_date":
                statement.auditDate = localizedDates(inputDate: " \(data)")
            case "conformity":
                if foundTotalResult {
                    if let conformity = Float(string) {
                        statement.conformityAverage = CGFloat(conformity / 100)
                        statement.conformityAverageDisplay = String(Int(conformity.rounded()))
                    }
                }
            case "technology":
                statement.technologies += "\(data)"
            case "version":
                statement.referentialVersion += " \(data)"
            case "level":
                statement.referentialLevel += data
            default:
                break
            }

            statement.identityName = Constants.Orange.identityName
            statement.identityAddress = Constants.Orange.identityAddress
            statement.referentialName = "WCAG " + statement.referentialVersion + " " + statement.referentialLevel
        }
    }

    func parserDidEndDocument(_: XMLParser) {
        Log.log("XML statement parsing completed.")
        statementDataUpdated()
    }

    func parser(_: XMLParser, parseErrorOccurred parseError: Error) {
        Log.error("Error occured while processing XML: '\(parseError.localizedDescription)'")
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
        if elementName == "result" {
            foundTotalResult = false
        }
    }

    // MARK: - Helpers

    private func statementDataUpdated() {
        NotificationCenter.default.post(name: Notification.Name("DeclarationDataDidUpdate"), object: nil, userInfo: ["declarationData": statement])
    }

    private func localizedDates(inputDate: String) -> (toDisplay: String, toVocalize: String)? {
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
