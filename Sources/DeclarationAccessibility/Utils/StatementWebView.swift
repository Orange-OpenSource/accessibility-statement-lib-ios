// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0
//
// This software is distributed under the Apache 2.0 license,
// the text of which is available at https://opensource.org/license/apache-2-0
// or see the "LICENSE" file for more details.

#if os(iOS)
import SwiftUI
import WebKit

/// A custom `UIViewRepresentable` providing a `WebView` to display the accessibility statement
struct StatementWebView: UIViewRepresentable {

    enum ContentSource {
        case url(URL)
        case html(String)
    }

    let source: ContentSource

    // MARK: - Initializers

    init(from url: URL) {
        source = .url(url)
    }

    init(with htmlContent: String) {
        source = .html(htmlContent)
    }

    // MARK: - UIViewRepresentable

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
#endif
