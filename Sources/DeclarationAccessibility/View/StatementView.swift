// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)

import OUDSSwiftUI
import SwiftUI

/// A `View` which will display the accessibility statement for a given theme.
/// It uses a theme from [OUDS library](https://github.com/Orange-OpenSource/ouds-ios) until this library is not included in OUDS.
///
/// # Parameters
///
/// - An XML file name available in bundle is needed to process the data. This file can be generated using [La va11ydette](https://la-va11ydette.orange.com/).
/// - Some themes can be used to style colors
/// - A URL can be given to display a local HTML page or an external page for more details.
/// - The use of a WebView permits to display the detailed page internally or not.
///
/// # Code samples
///
/// ```swift
///     // Where:
///     // - "fileName" is the name of the XML file containing the results of the accessibilit audits
///     // - "someURL" can be an absolute URL of an HTML file displaying a detailed page defined in app buundle
///     StatementView(xmlFileName: fileName, theme .orange, localURL: someURL)
///
///     // Or using an external HTML page, with a webview or not (by default no)
///     StatementView(xmlFileName: fileName, theme .orange, remoteUrl: someURL, useWebView: true)
/// ```
///
/// # Code samples (OUDS)
///
/// ```swift
///     // Where:
///     // - "fileName" is the name of the XML file containing the results of the accessibilit audits
///     // - "someURL" can be an absolute URL of an HTML file displaying a detailed page defined in app buundle
///     StatementView(xmlFileName: fileName, localURL: someURL, theme: someOudsTheme)
///
///     // Or using an external HTML page, with a webview or not (by default no)
///     StatementView(xmlFileName: fileName, remoteUrl: someURL, useWebView: true, theme: someOudsTheme)
///
///     // Note "someOudsTheme" is an instance of theme from OUDS library
/// ```
///
/// - Since: 2.0.0
public struct StatementView: View {

    /// The statement object with all the data
    private var statement: Statement

    /// The theme to apply
    private var theme: Theme?

    /// The theme from *OUDS* library to use
    private var oudsTheme: OUDSTheme?

    // MARK: - Initializers (deprecated)

    /// Defines the view for the accessibility statement.
    ///
    /// **Warning**: If `detailURL` points to an internal HTML page, `useWebView` must be set to *true*.
    ///
    /// - Parameters:
    ///    - xmlFileName: The name of the accessibilty statement XML file to process
    ///    - theme: The theme to apply
    ///    - detailUrl: The URL to use to go to more detailed statement web page
    ///    - useWebView: Flag saying ig a web view must be used or not, default set to `false`. Set to `true` if local HTML page is used.
    @available(*, deprecated, message: "Use StatementView(xmlFile:localUrl:theme:) or StatementView(xmlFile:remoteUrl:useWebView:theme:) instead")
    public init(xmlFileName: String, theme: Theme, detailUrl: String, useWebView: Bool = false) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFileName)
        statement = parser.statement
        statement.detailUrl = detailUrl
        statement.mustUseWebView = useWebView
        self.theme = theme
        oudsTheme = nil
    }

    /// Defines the view for the accessibility statement using a local HTML file for details.
    /// If the detailed HTML page must be loaded externaly, prefer instead ``init(xmlFile:theme:remoteUrl:useWebView:)``.
    ///
    /// - Parameters:
    ///    - xmlFile: The name of the accessibilty statement XML file to process, must be local in app bundle
    ///    - theme: The theme to apply
    ///    - localUrl: The URL to use to go to more detailed statement web page, must be a local HTML file
    @available(*, deprecated, message: "Use StatementView(xmlFile:localUrl:theme) instead")
    public init(xmlFile: String, theme: Theme, localUrl: String) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFile)
        statement = parser.statement
        statement.detailUrl = localUrl
        statement.mustUseWebView = true
        self.theme = theme
        oudsTheme = nil
    }

    /// Defines the view for the accessibility statement.
    /// If the detailed HTML page must be loaded internaly from app, prefer instead ``init(xmlFile:theme:localUrl:)``.
    ///
    /// - Parameters:
    ///    - xmlFile: The name of the accessibilty statement XML file to process, must be local in app bundle
    ///    - theme: The theme to apply
    ///    - remoteUrl: The URL to use to go to more detailed statement web page, supposed to be external HTML page
    ///    - useWebView: If the external HTML page msut be displayed in web view or not, default set to `false`
    @available(*, deprecated, message: "Use StatementView(xmlFile:remoteUrl:useWebView:theme) instead")
    public init(xmlFile: String, theme: Theme, remoteUrl: String, useWebView: Bool = false) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFile)
        statement = parser.statement
        statement.detailUrl = remoteUrl
        statement.mustUseWebView = useWebView
        self.theme = theme
        oudsTheme = nil
    }

    // MARK: Initializers (supported)

    /// Defines the view for the accessibility statement using a local HTML file for details.
    /// If the detailed HTML page must be loaded externaly, prefer instead ``init(xmlFile:remoteUrl:useWebView:theme)``.
    ///
    /// - Parameters:
    ///    - xmlFile: The name of the accessibilty statement XML file to process, must be local in app bundle
    ///    - localUrl: The URL to use to go to more detailed statement web page, must be a local HTML file
    ///    - theme: The theme to apply from OUDS library
    public init(xmlFile: String, localUrl: String, theme: OUDSTheme) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFile)
        statement = parser.statement
        statement.detailUrl = localUrl
        statement.mustUseWebView = true
        self.theme = nil
        oudsTheme = theme
    }

    // swiftlint:disable function_default_parameter_at_end
    /// Defines the view for the accessibility statement.
    /// If the detailed HTML page must be loaded internaly from app, prefer instead ``init(xmlFile:theme:localUrl:)``.
    ///
    /// - Parameters:
    ///    - xmlFile: The name of the accessibilty statement XML file to process, must be local in app bundle
    ///    - remoteUrl: The URL to use to go to more detailed statement web page, supposed to be external HTML page
    ///    - useWebView: If the external HTML page msut be displayed in web view or not, default set to `false`
    ///    - theme: The theme to apply from OUDS library
    public init(xmlFile: String, remoteUrl: String, useWebView: Bool = false, theme: OUDSTheme) {
        let parser = StatementDataParser()
        parser.parseXML(fileName: xmlFile)
        statement = parser.statement
        statement.detailUrl = remoteUrl
        statement.mustUseWebView = useWebView
        self.theme = nil
        oudsTheme = theme
    }

    // swiftlint:enable function_default_parameter_at_end

    // MARK: Initializers (debug)

    #if DEBUG
    /// Initializer dedicated to the Xcode Preview
    init(_ statement: Statement, theme: Theme) {
        self.statement = statement
        self.theme = theme
        oudsTheme = nil
    }
    #endif

    // MARK: - Body

    // swiftlint:disable force_unwrapping
    public var body: some View {
        let themeToApply = theme?.oudsTheme ?? oudsTheme! // NOTE: Can be bang! because not possible to have both themes nil
        ScrollView {
            VStack {
                CircularProgressView(statement: statement, theme: themeToApply)
                    .frame(maxWidth: .infinity)

                InformationView(statement: statement, theme: themeToApply)
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, themeToApply.spaces.fixedMedium)
        }
    }
    // swiftlint:enable force_unwrapping
}

extension Theme {

    /// Returns the corresponding OUDS theme instance
    ///
    /// - Returns: An OUDS theme object conforming to OUDSTheme protocol
    var oudsTheme: OUDSTheme {
        switch self {
        case .innovation, .wireframe:
            return WireframeTheme()
        case .orange:
            return OrangeTheme()
        case .orangeBusinessTools:
            return OrangeBusinessToolsTheme()
        case .sosh:
            return SoshTheme()
        }
    }
}

// MARK: - Xcode Preview

#Preview {
    StatementView(
        Statement(
            title: "Accessibility Statement",
            lang: "EN",
            auditDate: "22 janv. 2026",
            conformityAverage: 0.75,
            conformityAverageDisplay: "75",
            referentialName: "WCAG 2.2 AA",
            technologies: "Swift, SwiftUI",
            identityAddress: Constants.Orange.identityAddress,
            identityName: Constants.Orange.identityName),
        theme: .orange)
}
#endif
