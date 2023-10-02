//
// MIT License
// Copyright (c) 2023 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation

class DeclarationDataParser: NSObject, XMLParserDelegate {
    var declarations: Declaration = Declaration()
    private var currentElement = ""
    private var currentData = ""

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
    }

    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            switch self.currentElement {
            case "title_app":
                self.declarations.title += " \(data)"
            case "audit_date":
                self.declarations.auditDate += " \(data)"
                self.declarations.auditDate = self.dateToFrench(inputDate: self.declarations.auditDate)
            case "conformity":
                self.declarations.conformity += " \(data)"
                let result = declarations.conformity.split(separator: " ")
                let conformityArrayDouble = result.map { Double($0)! }
                let sumArray = conformityArrayDouble.reduce(0, +)
                let average = (sumArray / Double(conformityArrayDouble.count))
                let averageAsString = Int(average.rounded())
                self.declarations.conformityAverageDisplay = String(averageAsString)
                self.declarations.conformityAverage = CGFloat(average / 100)
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
