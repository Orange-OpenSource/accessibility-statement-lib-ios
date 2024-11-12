/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

import SwiftUI

public struct DeclarationView: View {

    // MARK: Properties

    var declarations: Declaration
    var selectedTheme: Theme

    // MARK: Initializer

    public init(xmlFileName: String, selectedTheme: Theme, url: String, useWebView: Bool = false) {
        let parser = DeclarationDataParser()
        parser.parseXML(fileName: xmlFileName)
        self.declarations = parser.declarations
        self.selectedTheme = selectedTheme
        self.declarations.detailUrl = url
        self.declarations.useWebView = useWebView
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
