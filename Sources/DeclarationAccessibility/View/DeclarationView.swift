//
//  SwiftUIView.swift
//
//
//  Created by Orange on 21/09/2023.
//

import SwiftUI

public struct DeclarationView: View {
    var declarations: Declaration
    var selectedTheme: Theme

    public init(xmlFileName: String, selectedTheme: Theme, url: String) {
        let parser = DeclarationDataParser()
        parser.parseXML(fileName: xmlFileName)
        self.declarations = parser.declarations
        self.selectedTheme = selectedTheme
        self.declarations.detailUrl = url
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CircularProgressView(declarations: declarations, selectedTheme: selectedTheme)
                        .frame(maxWidth: .infinity)
                    
                    InformationView(declarations: declarations)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 15)
            }
        }
    }
}

public struct DeclarationView_Previews: PreviewProvider {
    public static var previews: some View {
        DeclarationView(xmlFileName: "", selectedTheme: .innovation, url: "https://a11y-guidelines.orange.com/fr/")
    }
}
