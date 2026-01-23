# ``DeclarationAccessibility``

@Metadata {
    @DisplayName("Welcome to the Accessibility Statement Library for iOS", style: symbol)
    @TitleHeading("Swift Package")
}

## Overview

This is a library, exposed as a Swift Package, which will help you to display a legal accessibility statement for your application.
This library use XML report which can be generated from [La va11ydette](https://la-va11ydette.orange.com/?lang=en).

> Tip: Feel free to submit pull requests if you can improve the support of any platforms!

> Important: You used until now the version 1? Have [a look on the migration guide for v2](https://github.com/Orange-OpenSource/accessibility-statement-lib-ios/blob/develop/MIGRATION.md)

## How to use the library

When you get the dependency, import from the Swift Package the dedicated product:

```swift
import DeclarationAccessibility
```

You can integrate the dedicated `View` in your app, e.g. in about pages:

with local HTML file:
```swift
StatementView(xmlFileName: fileName, theme: .orange, localURL: someURL)
```

or loading external HTML page:
```swift
StatementView(xmlFileName: fileName, theme: .orange, remoteUrl: someURL, useWebView: true)
```

where:
- *fileName* is the name of the XML file containing the results of the accessibility audits
- *someURL* can be an absolute URL of an HTML file displaying a detailed page, or an external HTML page

> Tip: Note you can use La Va11ydette to generate such XML file (https://la-va11ydette.orange.com/)

More complete sample:

```swift
import DeclarationAccessibility

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
            StatementView(xmlFileName: "accessibility_result", theme: .orange, localURL: detailsPageURL.absoluteString)
        }
    }
}
```

## Data and privacy

The *accessibility-statement-lib-ios* library is a Software Development Kit (SDK) that allows developpers to display accessibility statement on mobile applications.
As such:
- this SDK does not handle any personnal data
- this SDK does not require any device permission to work
