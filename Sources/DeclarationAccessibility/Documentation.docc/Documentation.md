# ``DeclarationAccessibility``

@Metadata {
    @DisplayName("Welcome to the DeclarationAccessibility library", style: symbol)
    @TitleHeading("Swift Package")
}
<!-- 
Do not add @PageImage(purpose: card) because not managed for landing page of online doc.
See https://github.com/swiftlang/swift-docc/issues/1283
-->


## Overview

This is a library, exposed as a Swift Package, which will help you to display a legal accessibility statement for your application.

> Tip: Feel free to submit pull requests if you can improve the support of any platforms!

## How to use the library

You can integrate the dedicated `View` in your app, e.g. in about pages:

```swift
StatementView(xmlFileName: fileName, theme: .orange, detailURL: someURL, useWebView: true)
```

where:
- *fileName* is the name of the XML file containing the results of the accessibilit audits
- *someURL* can be an absolute URL of an HTML file displaying a detailed page

> Tip: Note you can use La Va11ydette to generate such XML file (https://la-va11ydette.orange.com/)

More complete sample:

```swift
struct AccessibilityStatementPage: View {

    let detailsPageURL: URL

    init() {
        guard let detailsPageURL = Bundle.main.url(forResource: "accessibility_detail", withExtension: "html") else {
            fatalError("Unable to find accessibility_detail.html in resources")
        }

        self.detailsPageURL = detailsPageURL
    }

    var body: some View {
        VStack {
            // Supposed to have "accessibility_result" XML file in app bundle
            // Here load a local HTML page ("accessibility_detail" HTML file in app bundle), forced to be in webview
            // Otherwise just use instead a String URL pointing to an external web page
            StatementView(xmlFileName: "accessibility_result", theme: .orange, detailURL: detailsPageURL.absoluteString, useWebView: true)
        }
    }
}
```

## Data and privacy

The *DeclarationAccessibility* library is a Software Development Kit (SDK) that allows developpers to display accessibility statement on mobile applications.
As such:
- this SDK does not handle any personnal data
- this SDK does not require any device permission to work
