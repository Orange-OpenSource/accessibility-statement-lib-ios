/*
 * Software Name: accessibility-statement-lib-ios
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: Apache-2.0
 *
 * This software is distributed under the Apache License 2.0.
 */

import SwiftUI

public struct DeclarationView: View {
    
    // =======================
    // MARK: Properties
    // =======================
    var declarations: Declaration
    var selectedTheme: Theme
    
    
    // =================
    // MARK: Initializer
    // =================
    
    public init(xmlFileName: String, selectedTheme: Theme, url: String) {
        let parser = DeclarationDataParser()
        parser.parseXML(fileName: xmlFileName)
        self.declarations = parser.declarations
        self.selectedTheme = selectedTheme
        self.declarations.detailUrl = url
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                CircularProgressView(declarations: declarations, selectedTheme: selectedTheme)
                    .frame(maxWidth: .infinity)
                
                InformationView(declarations: declarations, selectedTheme: selectedTheme)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 15)
        }
    }
}

public struct DeclarationView_Previews: PreviewProvider {
    public static var previews: some View {
        DeclarationView(xmlFileName: "", selectedTheme: .innovation, url: "https://a11y-guidelines.orange.com/fr/")
    }
}
