// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

import SwiftUI
import WebKit

struct EASEWebView: UIViewRepresentable {
    enum ContentSource {
        case url(URL)
        case html(String)
    }

    // MARK: Stored properties

    let source: ContentSource

    // MARK: Initializer

    init(from url: URL) {
        source = .url(url)
    }

    init(with htmlContent: String) {
        source = .html(htmlContent)
    }

    // MARK: UIViewRepresentable

    @MainActor
    func makeUIView(context _: Context) -> WKWebView {
        WKWebView()
    }

    @MainActor
    func updateUIView(_ webView: WKWebView, context _: Context) {
        switch source {
        case let .url(url):
            let request = URLRequest(url: url)
            webView.load(request)
        case let .html(string):
            webView.loadHTMLString(string, baseURL: nil)
        }
    }
}
