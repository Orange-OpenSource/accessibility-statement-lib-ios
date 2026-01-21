// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import SwiftUI

public struct DeclarationView: View {
    // MARK: Properties

    var declarations: Declaration
    var selectedTheme: Theme

    // MARK: Initializer

    public init(xmlFileName: String, selectedTheme: Theme, url: String, useWebView: Bool = false) {
        let parser = DeclarationDataParser()
        parser.parseXML(fileName: xmlFileName)
        declarations = parser.declarations
        self.selectedTheme = selectedTheme
        declarations.detailUrl = url
        declarations.useWebView = useWebView
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
