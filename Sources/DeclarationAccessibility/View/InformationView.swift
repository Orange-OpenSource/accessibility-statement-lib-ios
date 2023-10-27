/*
 * Software Name: accessibility-statement-lib-ios
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: Apache-2.0
 *
 * This software is distributed under the Apache License 2.0.
 */

import SwiftUI

public struct InformationView: View {
    
    // =======================
    // MARK: Properties
    // =======================
    var declarations: Declaration
    public var selectedTheme: Theme
    
    public var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                GroupView(title: "date_title", subTitle: declarations.auditDate)
                    .accessibilityElement(children: .combine)
                GroupView(title: "identity_title", subTitle: declarations.identityName, text: declarations.identityAdresse)
                    .accessibilityElement(children: .combine)
                GroupView(title: "referential_title", subTitle: declarations.referentialName)
                    .accessibilityElement(children: .combine)
                GroupView(title: "technology_title", subTitle: declarations.technologies)
                    .accessibilityElement(children: .combine)
            }
            
            HStack {
                Button(action: {
                    if let url = URL(string: declarations.detailUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    if #available(iOS 16.0, *) {
                        Text("detail_button", bundle: .module)
                            .padding()
                            .background(selectedTheme.buttonColor)
                            .foregroundColor(selectedTheme.foregroundColor)
                            .font(.title3).bold()
                    } else {
                        Text("detail_button", bundle: .module)
                            .padding()
                            .background(selectedTheme.buttonColor)
                            .foregroundColor(selectedTheme.foregroundColor)
                            .font(.title3)
                    }
                }
            }
        }
    }
}


public struct GroupView: View {
    let title: LocalizedStringKey
    let subTitle: String
    let text: String?

    public init(title: LocalizedStringKey, subTitle: String, text: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title, bundle: .module)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subTitle)
                .font(.body)
            if let text = text {
                Text(text)
                    .font(.body)
            }
        }
        .padding()
    }
}


struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(declarations: Declaration(
            auditDate: "Test Audit Date",
            referentialName: "Test Referential Name",
            referentialVersion: "Test Referential Version",
            referentialLevel: "Test Referential Level",
            technologies: "Test Technologies",
            detailUrl: "https://example.com",
            identityAdresse: "Test Identity Adresse",
            identityName: "Test Identity Name"
        ), selectedTheme: .orange)
        .environment(\.locale,.init(identifier: "fr"))
    }
}
