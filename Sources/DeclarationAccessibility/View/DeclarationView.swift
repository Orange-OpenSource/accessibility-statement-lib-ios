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

    public init(xmlFileName: String, selectedTheme: Theme) {
        let parser = DeclarationDataParser()
        parser.parseXML(fileName: xmlFileName)
        self.declarations = parser.declarations
        self.selectedTheme = selectedTheme
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CircularProgressView(declarations: declarations, selectedTheme: selectedTheme)
                        .frame(maxWidth: .infinity) // Utilisez maxWidth pour occuper toute la largeur
                    
                    InformationView(declarations: declarations)
                        .frame(maxWidth: .infinity) // Utilisez maxWidth pour occuper toute la largeur
                }
                .padding(.top, 15)
            }
            .navigationBarTitle("Declaration")
        }
    }
}

public struct DeclarationView_Previews: PreviewProvider {
    public static var previews: some View {
        DeclarationView(xmlFileName: "", selectedTheme: .innovation)
    }
}
