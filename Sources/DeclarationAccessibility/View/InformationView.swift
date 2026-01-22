// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)
import SwiftUI
import OUDSSwiftUI

// MARK: - Information View

/// A `View` displaying details of the accessiiblity statement
struct InformationView: View {

    var statement: Statement
    @Environment(\.theme) private var theme

    var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                GroupView(title: "date_title", subTitle: statement.auditDate)
                    .accessibilityElement(children: .combine)
                GroupView(title: "identity_title", subTitle: statement.identityName, text: statement.identityAddress)
                    .accessibilityElement(children: .combine)
                GroupView(title: "referential_title", subTitle: statement.referentialName)
                    .accessibilityElement(children: .combine)
                GroupView(title: "technology_title", subTitle: statement.technologies)
                    .accessibilityElement(children: .combine)
            }

            HStack {
                if statement.mustUseWebView {
                    NavigationLink(
                        destination: WebViewPage(url: statement.detailUrl),
                        label: {
                            OUDSButton(text: NSLocalizedString("detail_button", bundle: .module, comment: ""), appearance: .strong) {
                                // Navigation is handled by NavigationLink
                            }
                        })
                } else {
                    OUDSButton(text: NSLocalizedString("detail_button", bundle: .module, comment: ""), appearance: .strong) {
                        if let url = URL(string: statement.detailUrl) {
                            UIApplication.shared.open(url)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Group View

private struct GroupView: View {

    let title: LocalizedStringKey
    let subTitle: String
    let text: String?
    @Environment(\.theme) private var theme

    init(title: LocalizedStringKey, subTitle: String, text: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.text = text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title, bundle: .module)
                .headingMedium(theme)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subTitle)
                .bodyDefaultLarge(theme)
            if let text {
                Text(text)
                    .bodyDefaultLarge(theme)
            }
        }
        .padding(theme.spaces.fixedSmall)
    }
}

// MARK: - Web View Page

private struct WebViewPage: View {
    var url: String

    // swiftlint:disable force_unwrapping
    var body: some View {
        StatementWebView(from: URL(string: url)!) // TODO: Manage this error case
            .navigationTitle("Details") // TODO: Hard-coded not localized wording
    }
    // swiftlint:enable force_unwrapping
}

// MARK: - Xcode Preview

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        OUDSThemeableView(theme: OrangeTheme()) {
            InformationView(statement: Statement(
                auditDate: "Test Audit Date",
                referentialName: "Test Referential Name",
                referentialVersion: "Test Referential Version",
                referentialLevel: "Test Referential Level",
                technologies: "Test Technologies",
                detailUrl: "https://example.com",
                identityAddress: "Test Identity Address",
                identityName: "Test Identity Name"))
                .environment(\.locale, .init(identifier: "fr"))
        }
    }
}

#endif
