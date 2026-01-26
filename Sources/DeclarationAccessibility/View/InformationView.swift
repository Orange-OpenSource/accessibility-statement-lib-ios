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

// MARK: - Information View

/// A `View` displaying details of the accessiiblity statement
struct InformationView: View {

    var statement: Statement
    var theme: OUDSTheme

    @State private var showWebView = false

    var body: some View {
        ScrollView {
            VStack(spacing: -10) {
                if let auditDate = statement.auditDate {
                    GroupView(title: "date_title", subTitle: auditDate.toDisplay)
                        .accessibilityElement(children: .combine)
                        .accessibilityValue(auditDate.toVocalize.isEmpty
                            ? auditDate.toDisplay
                            : auditDate.toVocalize)
                }
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
                        isActive: $showWebView)
                    {
                        EmptyView()
                    }
                    .hidden()

                    OUDSButton(text: NSLocalizedString("detail_button", bundle: .module, comment: ""),
                               appearance: .strong)
                    {
                        showWebView = true
                    }
                } else {
                    OUDSButton(text: NSLocalizedString("detail_button", bundle: .module, comment: ""),
                               appearance: .strong)
                    {
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
        VStack(alignment: .leading, spacing: theme.spaces.fixedXsmall) {
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
        StatementWebView(from: URL(string: url)!) // FIXME: Manage this error case
            .navigationTitle(NSLocalizedString( // FIXME: Change API
                "declaration_title",
                bundle: .module,
                comment: ""))
    }
    // swiftlint:enable force_unwrapping
}

// MARK: - Xcode Preview

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(statement: Statement(
            auditDate: (toDisplay: "Test Audit Date", toVocalize: ""),
            referentialName: "Test Referential Name",
            referentialVersion: "Test Referential Version",
            referentialLevel: "Test Referential Level",
            technologies: "Test Technologies",
            detailUrl: "https://example.com",
            identityAddress: "Test Identity Address",
            identityName: "Test Identity Name"),
        theme: WireframeTheme())
            .environment(\.locale, .init(identifier: "fr"))
            .wireframePreview()
    }
}

#endif
