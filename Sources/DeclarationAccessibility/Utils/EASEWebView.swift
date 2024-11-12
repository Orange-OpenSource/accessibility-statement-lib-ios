/*
* Software Name: accessibility-statement-lib-ios
* SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
* SPDX-License-Identifier: Apache-2.0
*
* This software is distributed under the Apache License 2.0.
*/

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
        self.source = .url(url)
    }

    init(with htmlContent: String) {
        self.source = .html(htmlContent)
    }

    // MARK: UIViewRepresentable

    @MainActor
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    @MainActor
    func updateUIView(_ webView: WKWebView, context: Context) {
        switch source {
        case let .url(url):
            let request = URLRequest(url: url)
            webView.load(request)
        case let .html(string):
            webView.loadHTMLString(string, baseURL: nil)
        }
    }
}
