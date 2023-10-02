//
// MIT License
// Copyright (c) 2023 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import SwiftUI

public struct InformationView: View {
    
    // =======================
    // MARK: Properties
    // =======================
    var declarations: Declaration
    
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
                    Text("detail_button", bundle: .module)
                        .padding()
                        .background(Color(UIColor.label))
                        .foregroundColor(Color(UIColor.systemBackground))
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
        ))
        .environment(\.locale,.init(identifier: "fr"))
    }
}
