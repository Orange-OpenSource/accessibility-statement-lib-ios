// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import SwiftUI

/// A `View` which will display the accessibility statement for a given theme
///
/// - Since: 2.0.0
public struct StatementView: View {

    /// The statement object with all the data
    private var statement: Statement

    /// The theme to apply
    private var theme: Theme

    /// Defines the view for the accessibility statement
    ///
    /// - Parameters:
    ///    - xmlFileName: The name of the accessibilty statement XML file to process
    ///    - theme: The theme to apply
    ///    - detailUrl: The URL to use to go to more detailed statement web page
    ///    - useWebView: Flag saying ig a web view must be used or not, default set to false
    public init(xmlFileName: String, theme: Theme, detailUrl: String, useWebView: Bool = false) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFileName)
        statement = parser.statement
        self.theme = theme
        statement.detailUrl = detailUrl
        statement.mustUseWebView = useWebView
    }

    public var body: some View {
        ScrollView {
            VStack {
                CircularProgressView(statement: statement, theme: theme)
                    .frame(maxWidth: .infinity)

                InformationView(statement: statement, theme: theme)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 15)
        }
    }
}
