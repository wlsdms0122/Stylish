# Stylish
`Stylish` is a library that helps you quickly and easily create user styles when creating custom views in `SwiftUI`.

In 2019, the UI paradigm shifted when `Apple` introduced `SwiftUI`. The styling and propagation of UI Components is very interesting, but styling with [Environment](https://developer.apple.com/documentation/swiftui/environment) is not free from naming duplication and customization.

`Stylish` solves these problems to help you reduce boilerplate code and increase productivity.

- [Stylish](#stylish)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
- [Getting Started](#getting-started)
  - [Styling Component](#styling-component)
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
Using `Stylish` is straightforward. To create a styled component, add the `@Stylish` macro to your styles.

```swift
@Stylish
struct MyButtonStyles {
    var textColor: Color = .black
}
```

The `@Stylish` macro automatically adopts the `Stylish` protocol to manage configurations.

You can access the `@Styles` property wrapper in your view to use `Stylish` styles for custom components.

```swift
struct MyButton: View {
    var body: some View {
        Button {

        } label: {
            Text("Touch!")
                .foregroundColor(styles.textColor)
        }
    }

    @Styles(MyButtonStyles.self)
    private var styles
}
```

That's it! Now, modify the view using the `configure(_:style:to:)` modifier.

```swift
struct ContentView: View {
    var body: some View {
        MyButton()
            .configure(MyButtonStyles.self, style: \.textColor, to: .green)
    }
}
```

## Styling Component
The `@Stylish` macro automatically adds the `@Config` attribute to each style property. It helps you to create a custom style like `.buttonStyle(_:)`.

In `SwiftUI`, properties specified by the user using view modifiers have the highest priority. However, in styling, subsequent styles should override even if the user has set the style.

```swift
MyButton()
    .configure(MyButtonStyles.self, style: \.style, to: .card)
    .configure(MyButtonStyles.self, style: \.textColor, to: .green)
```

For example, with a card-type `MyButtonStyle` setting the foreground color of the button title to "blue", subsequent styles should override this, similar to a real `ButtonStyle`.

You can use `@Config` like this:

```swift
@Stylish
struct MyButtonStyles {
    var style: any MyButtonStyle = .plain
    var textColor: Color = .black
}

/// Card style button. It sets the foreground color of the button title to blue.
/// `styles.$foregroundColor(.blue)` is used to set the foreground color of the button title to blue.
struct CardMyButtonStyle: MyButtonStyle {
    private struct Content: View {
        var body: some View {
            configuration.label
                .configure(
                    MyButtonStyles.self, 
                    style: \.foregroundColor,
                    to: styles.$foregroundColor(.blue)
                )
        }
        
        private let configuration: Configuration
        
        @Styles(MyButtonStyles.self)
        var styles
        
        init(_ configuration: Configuration) {
            self.configuration = configuration
        }
    }
    
    func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration)
    }
}

struct MyButton: View {
    private struct Content: View {
        var body: some View {
            Button {

            } label: {
                Text("Touch!")
                    .foregroundColor(styles.textColor)
            }
        }

        @Styles(MyButtonStyles.self)
        var styles
    }

    var body: some View {
        AnyView(
            style.makeBody(.init(
                label: .init(Content())
            ))
        )
    }

    @Styles(MyButtonStyles.self, style: \.style)
    var style
}
```

The `projectedValue` of the `@Config` property wrapper returns a function, which returns the value you pass in only if the property is not specified.

# Contribution
Any ideas, issues, opinions are welcome.

# License
`Stylish` is available under the MIT license. See the LICENSE file for more info.
