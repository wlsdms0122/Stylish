# Stylish
`Stylish` is a library that helps you quickly and easily create user styles when creating custom views in `SwiftUI`.

In 2019, the UI paradigm shifted when `Apple` introduced `SwiftUI`. The styling and propagation of UI Components is very interesting, but styling with [Environment](https://developer.apple.com/documentation/swiftui/environment) is not free from naming duplication and customization.

`Stylish` solves these problems to help you reduce boilerplate code and increase productivity.

- [Stylish](#reducer)
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
    .package(url: "https://github.com/wlsdms0122/Stylish.git", .upToNextMajor(from: "1.0.0"))
]
```

# Getting Started
Using Stylish is straightforward. To create a styled component, add the @Stylish macro to your view.

```swift
@Stylish
struct MyButton: View {
    var body: some View {
        Button {
            // TODO: action
        } label: {
            Text("Touch!")
        }
    }
}
```

The `@Stylish` macro automatically adopts the `Stylish` protocol. Define a `Configuration` to satisfy the protocol and to apply the style on your view.

And you need to add the `@Style` macro in the `Configuration`. The `@Style` macros allow you to style the view, just like using `Environment`.

```swift
@Stylish
struct MyButton: View {
    @Style
    struct Configuration {
        var foregroundColor: Color = .black
    }
    ...
}
```

Finally, utilize the specified style using the `@EnvironmentConfig` property wrapper to read the style values specified in the view.

```swift
@Stylish
struct MyButton: View {
    @Style
    struct Configuration {
        var foregroundColor: Color = .black
    }

    var body: some View {
        Button {

        } label: {
            Text("Touch!")
                .foregroundColor(config.foregroundColor)
        }
    }

    @EnvironmentConfig(MyButton.self)
    var config
}
```

That's it! Now, modify the view using the `configure(_:path:_:)` modifier.

```swift
struct ContentView: View {
    var body: some View {
        MyButton()
            .configure(MyButton.self, path: \.foregroundColor, .green)
    }
}
```

## Config property wrapper
The `@Style` macro automactically add `@Config` attribute on configuration's properties.

When you create custom style like `.buttonSyle(_:)`, you need to set default styles.

In `SwiftUI`, properties specified by the user using the view modifier have the highest priority. However, in styling, subsequent styles should override even if the user sets the style.

```swift
MyButton()
    .configure(MyButton.self, path: \.style, .card)
    .configure(MyButton.self, path: \.foregroundColor, .green)
```

For example, with a card type `MyButtonStyle` setting the foreground color of the button title to blue, subsequent styles should override this, similar to a real `ButtonStyle`.

Utilize the `@Config` property wrapper for this:

```swift
public struct CardMyButtonStyle: MyButtonStyle {
    private struct Content: View {
        var body: some View {
            configuration.label
                .configure(MyButton.self, path: \.foregroundColor, config.$foregroundColor(.blue))
        }
        
        private let configuration: Configuration
        
        @EnvironmentConfig(MyButton.self)
        var config
        
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
