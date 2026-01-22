// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)

import SwiftUI

/// A `View` which will display the accessibility statement for a given theme.
///
/// # Parameters
///
/// - An XML file name available in bundle is needed to process the data. This file can be generated using [La va11ydette](https://la-va11ydette.orange.com/).
/// - Somle themes can be used to style colors (Orange, Innovation Cup, Sosh).
/// - A URL can be given to display a local HTML page or an external page for more details.
/// - The use of a WebView permits to display the detailed page internally or not.
///
/// # Code samples
///
/// ```swift
///     // Where:
///     // - "fileName" is the name of the XML file containing the results of the accessibilit audits
///     // - "someURL" can be an absolute URL of an HTML file displaying a detailed page defined in app buundle
///     StatementView(xmlFileName: fileName, theme: .orange, localURL: someURL)
///
///     // Or using an external HTML page, with a webview or not (by default no)
///     StatementView(xmlFileName: fileName, theme: .orange, remoteUrl: someURL, useWebView: true)
/// ```
///
/// - Since: 2.0.0
public struct StatementView: View {

    /// The statement object with all the data
    private var statement: Statement

    /// The theme to apply
    private var theme: Theme

    // MARK: - Initializers

    /// Defines the view for the accessibility statement.
    ///
    /// **Warning**: If `detailURL` points to an internal HTML page, `useWebView` must be set to *true*.
    ///
    /// - Parameters:
    ///    - xmlFileName: The name of the accessibilty statement XML file to process
    ///    - theme: The theme to apply
    ///    - detailUrl: The URL to use to go to more detailed statement web page
    ///    - useWebView: Flag saying ig a web view must be used or not, default set to `false`. Set to `true` if local HTML page is used.
    @available(*, deprecated, message: "Use StatementView(xmlFile:theme:localUrl:) or StatementView(xmlFile:theme:remoteUrl:useWebView:) instead")
    public init(xmlFileName: String, theme: Theme, detailUrl: String, useWebView: Bool = false) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFileName)
        statement = parser.statement
        self.theme = theme
        statement.detailUrl = detailUrl
        statement.mustUseWebView = useWebView
    }

    /// Defines the view for the accessibility statement using a local HTML file for details.
    /// If the detailed HTML page must be loaded externaly, prefer instead ``init(xmlFile:theme:remoteUrl:useWebView:)``.
    ///
    /// - Parameters:
    ///    - xmlFile: The name of the accessibilty statement XML file to process, must be local in app bundle
    ///    - theme: The theme to apply
    ///    - localUrl: The URL to use to go to more detailed statement web page, must be a local HTML file
    public init(xmlFile: String, theme: Theme, localUrl: String) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFile)
        statement = parser.statement
        self.theme = theme
        statement.detailUrl = localUrl
        statement.mustUseWebView = true
    }

    /// Defines the view for the accessibility statement.
    /// If the detailed HTML page must be loaded internaly from app, prefer instead ``init(xmlFile:theme:localUrl:)``.
    ///
    /// - Parameters:
    ///    - xmlFile: The name of the accessibilty statement XML file to process, must be local in app bundle
    ///    - theme: The theme to apply
    ///    - remoteUrl: The URL to use to go to more detailed statement web page, supposed to be external HTML page
    ///    - useWebView: If the external HTML page msut be displayed in web view or not, default set to `false`
    public init(xmlFile: String, theme: Theme, remoteUrl: String, useWebView: Bool = false) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFile)
        statement = parser.statement
        self.theme = theme
        statement.detailUrl = remoteUrl
        statement.mustUseWebView = useWebView
    }

    // MARK: - Body

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

#endif
