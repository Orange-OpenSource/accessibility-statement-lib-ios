# DeclarationAccessibility

Accessibility Statement Library contains a view showing the WCAG compliance status for its iOS application.

To use it, you need the XML accessibility result file from the [Orange va11ydette](https://la-va11ydette.orange.com/)

![Accessibility statement screen](preview_accessibility_statement.png)


Import Accessibility Statement lib in your project
------

1. To integrate DeclarationAccessibility into your Xcode project using _Swift Package Manager_, declare a new dependency:

```swift
// Add in the dependencies of your Package.swift
.package(url: "https://github.com/Orange-OpenSource/accessibility-statement-lib-ios.git", .exact("1.0.0"))

```

2. Then add the dependency product in the target you want:

```swift
.target(
    name: "YourTargetName",
    dependencies: [
        .product(name: "DeclarationAccessibility", package: "accessibility-statement-lib-ios")
    ],
)
```


Usage
-----

```swift
DeclarationView(xmlFileName: "accessibility_result", selectedTheme: .orange, url: "https://a11y-guidelines.orange.com/fr/")
```

* Add the results XML file from the va11ydette in racine folder of your project and rename it "accessibility_result.xml"
* Add xmlFileName, selectedTheme (orange, sosh, or innnovation) and url to DeclarationView
* By default, the URL will open in Safari. If you wish to open the details page in a WebView, you need to set the 'useWebView: true' parameter, with the HTML page loaded locally

Example with Safari
-----

1. To integrate DeclarationView
```swift
import SwiftUI
import DeclarationAccessibility

// MARK: Body

struct SwiftUIView: View {
    var body: some View {
        VStack {
            DeclarationView(xmlFileName: "accessibility_result", selectedTheme: .orange, url: "https://a11y-guidelines.orange.com/fr/")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
```

Example with a WebView
-----

1. To integrate DeclarationView
```swift
import DeclarationAccessibility
import SwiftUI

struct SwiftUIView: View {

    // MARK: Stored properties

    let detailsPageURL: URL

    // MARK: Initializer

    init() {
        guard let detailsPageURL = Bundle.main.url(forResource: "accessibility_detail", withExtension: "html") else {
            fatalError("Unable to find accessibility_detail.html in resources")
        }

        self.detailsPageURL = detailsPageURL
    }

    // MARK: Body

    var body: some View {
        VStack {
            DeclarationView(xmlFileName: "accessibility_result", selectedTheme: .orange, url: detailsPageURL.absoluteString, useWebView: true)
        }
    }
}
```
