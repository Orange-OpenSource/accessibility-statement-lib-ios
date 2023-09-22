//
//  SwiftUIView.swift
//  
//
//  Created by Tayeb SEDRAIA on 22/09/2023.
//

import SwiftUI

public struct InformationView: View {
    var declarations: Declaration
    public var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                GroupView(title: "Date of Audit", subTitle: declarations.auditDate)
                    .accessibilityElement(children: .combine)
                GroupView(title: "Identity of the declarant", subTitle: declarations.identityName, text: declarations.identityAdresse)
                    .accessibilityElement(children: .combine)
                GroupView(title: "Repository", subTitle: declarations.referentialName)
                    .accessibilityElement(children: .combine)
                GroupView(title: "Application technology", subTitle: declarations.technologies)
                    .accessibilityElement(children: .combine)
            }
            
            HStack {
                Button(action: {
                    if let url = URL(string: declarations.detailUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("More details")
                        .padding()
                        .background(Color(UIColor.label))
                        .foregroundColor(Color(UIColor.systemBackground))
                }
            }
        }
    }
}



public struct GroupView: View {
    let title: String
    let subTitle: String
    let text: String?

    init(title: String, subTitle: String, text: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.text = text
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.leading) // Text alignment across multiple lines.
                .frame(maxWidth: .infinity, alignment: .leading) // Left text alignment.
            Text(subTitle)
                .font(.body)
            if let text = text, !text.isEmpty {
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
        ))
    }
}
