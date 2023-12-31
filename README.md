# Stylish
`Stylish` is a library that helps you quickly and easily create user styles when creating custom views in `SwiftUI`.

In 2019, the UI paradigm shifted when `Apple` introduced `SwiftUI`. The styling and propagation of UI Components is very interesting, but styling with [Environment](https://developer.apple.com/documentation/swiftui/environment) is not free from naming duplication and customization.

`Stylish` solves these problems to help you reduce boilerplate code and increase productivity.

- [Stylish](#stylish)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
- [Getting Started](#getting-started)
  - [Config property wrapper](#config-property-wrapper)
- [Contribution](#contribution)
- [License](#license)

# Requirements
- Swift 5.9+ (Macro Support)
- iOS 13.0+
- macOS 10.15+
- macCatalyst 13.0+
- tvOS 13.0+
- watchOS 6.0+

# Installation
## Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/wlsdms0122/Stylish.git", .upToNextMajor(from: "2.0.0"))
]
```

# Getting Started
Using Stylish is straightforward. To create a styled component, add the @Stylish macro to your styles.

```swift
@Stylish
struct MyStyle {
    var textColor: Color = .black
}
```

The `@Stylish` macro automatically adopts the `Stylish` protocol to manage configurations.

And you can access `@Styles` property wrapper on your view to use `Stylish` styles for custom component.

```swift
struct MyButton: View {
    var body: some View {
        Button {

        } label: {
            Text("Touch!")
                .foregroundColor(styles.textColor)
        }
    }

    @Styles(MyStyle.self)
    private var styles
}
```

That's it! Now, modify the view using the `configure(_:style:to:)` modifier.

```swift
struct ContentView: View {
    var body: some View {
        MyButton()
            .configure(
                MyButton.self, 
                style: \.textColor, 
                to: .green
            )
    }
}
```

## Config property wrapper
The `@Stylish` macro automactically add `@Config` attribute on style properties.

When you create custom style like `.buttonSyle(_:)`, you need to set default styles.

In `SwiftUI`, properties specified by the user using the view modifier have the highest priority. However, in styling, subsequent styles should override even if the user sets the style.

```swift
MyButton()
    .configure(MyButton.self, style: \.style, to: .card)
    .configure(MyButton.self, style: \.foregroundColor, to: .green)
```

For example, with a card type `MyButtonStyle` setting the foreground color of the button title to blue, subsequent styles should override this, similar to a real `ButtonStyle`.

Utilize the `@Config` property wrapper for this:

```swift
public struct CardMyButtonStyle: MyButtonStyle {
    private struct Content: View {
        var body: some View {
            configuration.label
                .configure(
                    MyButton.self, 
                    style: \.foregroundColor,
                    to: styles.$foregroundColor(.blue)
                )
        }
        
        private let configuration: Configuration
        
        @Styles(MyButton.self)
        var styles
        
        init(_ configuration: Configuration) {
            self.configuration = configuration
        }
    }
    
    public func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration)
    }
}
```

The `projectedValue` of the `@Config` property wrapper returns a function, which only returns the value you pass in if the property is not specified.

# Contribution
Any ideas, issues, opinions are welcome.

# License
Stylish is available under the MIT license. See the LICENSE file for more info.
