# DeclarationAccessibility

Accessibility Statement Library contains a view showing the WCAG compliance status for its iOS application.

To use it, you need the XML accessibility result file from the [Orange va11ydette](https://la-va11ydette.orange.com/)

![Accessibility statement screen](preview_accessibility_statement.png)


Import Accessibility Statement lib in your project
------

1. To integrate DeclarationAccessibility into your Xcode project using Swift Package Manager

```
https://github.com/Orange-OpenSource/accessibility-statement-lib-ios.git"
```


Usage
-----
```swift
DeclarationView(xmlFileName: "accessibility_result")
```

* Add the results XML file from the va11ydette in racine folder of your project and rename it "accessibility_result.xml"
* Add the "xmlFileName" attribute of the DeclarationView method



Exemple
-----

1. To integrate DeclarationView
```swift
import SwiftUI
import DeclarationAccessibility

struct SwiftUIView: View {
    var body: some View {
        VStack {
           DeclarationView(xmlFileName: "orange-design-system")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
```


