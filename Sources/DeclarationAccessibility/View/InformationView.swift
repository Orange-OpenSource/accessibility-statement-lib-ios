// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)
import SwiftUI

// MARK: - Information View

/// A `View` displaying details of the accessiiblity statement
struct InformationView: View {

    var statement: Statement
    var theme: Theme

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
                            Text("detail_button", bundle: .module)
                                .padding()
                                .background(theme.buttonColor)
                                .foregroundColor(theme.foregroundColor)
                                .font(.title3)
                        })
                } else {
                    Button(action: {
                        if let url = URL(string: statement.detailUrl) {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Text("detail_button", bundle: .module)
                            .padding()
                            .background(theme.buttonColor)
                            .foregroundColor(theme.foregroundColor)
                            .font(.title3)
                    })
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

    init(title: LocalizedStringKey, subTitle: String, text: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.text = text
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title, bundle: .module)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subTitle)
                .font(.body)
            if let text {
                Text(text)
                    .font(.body)
            }
        }
        .padding()
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
        InformationView(statement: Statement(
            auditDate: "Test Audit Date",
            referentialName: "Test Referential Name",
            referentialVersion: "Test Referential Version",
            referentialLevel: "Test Referential Level",
            technologies: "Test Technologies",
            detailUrl: "https://example.com",
            identityAddress: "Test Identity Address",
            identityName: "Test Identity Name"),
        theme: .orange)
            .environment(\.locale, .init(identifier: "fr"))
    }
}

#endif
