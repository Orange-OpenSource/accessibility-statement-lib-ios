//
//  DeclarationDataParser.swift
//  DeclarationAccessibility
//
//  Created by Tayeb SEDRAIA on 21/09/2023.
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
                print("Erreur lors de la création de l'analyseur XML.")
            }
        } else {
            print("Fichier XML introuvable dans le bundle.")
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
