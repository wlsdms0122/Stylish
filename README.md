# Stylish
`Stylish` is a library that helps you quickly and easily create user styles when creating custom views in `SwiftUI`.

In 2019, the UI paradigm shifted when `Apple` introduced `SwiftUI`. The styling and propagation of UI Components is very interesting, but styling with [Environment](https://developer.apple.com/documentation/swiftui/environment) is not free from naming duplication and customization.

`Stylish` solves these problems to help you reduce boilerplate code and increase productivity.

- [Stylish](#stylish)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#swift-package-manager)
- [Getting Started](#getting-started)
  - [Advanced Usage](#advanced-usage)
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
    .package(url: "https://github.com/wlsdms0122/Stylish.git", from: "3.0.0")
]
```

# Getting Started
Using `Stylish` is straightforward. To create a styled component, add the `@Stylish` macro to your styles.

The `@Stylish` macro automatically adopts the `Stylish` protocol to manage configurations.

```swift
@Stylish
struct MyButtonOption {
    var backgroundColor: Color = .blue
}
```

Then, add the `@StyledComponent` macro to your view. When you use the `@StyledComponent` macro, you can access the `option` property to style the view.

```swift
@StyledComponent(MyButtonOption.self)
struct MyButton: View {
    var body: some View {
        Button {

        } label: {
            Text("Touch!")
                .backgroundColor(option.backgroundColor)
        }
    }
}
```

That's it! Now, modify the view using the `config(_:style:to:)` modifier.

```swift
struct ContentView: View {
    var body: some View {
        MyButton()
            .config(MyButton.self, style: \.backgroundColor, to: .green)
    }
}
```

## `@Stylish`

The `Stylish` protocol is central to this library, representing a set of styles. You can use the `@Stylish` macro to simplify the creation of these style objects, or implement the `Stylish` protocol manually.

### Using the `@Stylish` Macro

The `@Stylish` macro is a convenient way to construct `Stylish` objects.

```swift
@Stylish
struct MyButtonOption {
    var backgroundColor: Color = .yellow
}
```

### Manual Implementation

Alternatively, you can manually implement the `Stylish` protocol.

```swift
struct MyButtonOption: Stylish {
    @Config
    var backgroundColor: Color = .yellow

    init() { }
}
```

### Separation by Meaning

`Stylish` objects can be separated by their styling purpose. For example, you might have different structs for foreground and background styling.

```swift
@Stylish
struct ButtonForegroundOption {
    var color: Color = .black
}

@Stylish
struct ButtonBackgroundOption {
    var color: Color = .yellow
}
```

This separation allows for more modular and reusable style definitions.

## `@Style`

You can use the `@Style` property wrapper to access the entire set of styles defined in a `Stylish` object.

```swift
struct MyButton: View {
    var body: some View {
        Button {

        } label: {
            Text("Touch!")
                .backgroundColor(option.backgroundColor)
        }
    }

    @Style(MyButtonOption.self)
    private var option
}
```

If you only need to access specific style properties, you can do so by specifying the desired property in the `@Style` property wrapper.

```swift
@Style(MyButtonOption.self, style: \.backgroundColor)
private var backgroundColor
```

## `@StyledComponent`

The basic pattern is that one view has its own style set. While there are many ways to do this, you can use the `@StyledComponent` macro to reduce the boilerplate in the most basic implementations.

```swift
@StyledComponent(MyButtonOption.self)
struct MyButton: View {
    var body: some View {
        Button {

        } label: {
            Text("Touch!")
                .backgroundColor(option.backgroundColor)
        }
    }
}
```

The `StyledComponent` protocol requires defining the `StyleOption` type.

It makes it easier to organize and access. The `@Style` property wrapper needs a `Stylish` object type, but `StyledComponent` is also allowed.

```swift
@Style(MyButton.self)
private var option
```

The `config` view modifier is also allowed with `StyledComponent`.

```swift
MyButton { ... }
    .config(MyButton.self, style: \.backgroundColor, to: .green)
```

## Advanced Usage
### Styling Component
The `@Stylish` macro automatically adds the `@Config` attribute to each style property. It helps you to create a custom style like `.buttonStyle(_:)`.

In `SwiftUI`, properties specified by the user using view modifiers have the highest priority. However, in styling, subsequent styles should override even if the user has set the style.

```swift
MyButton()
    .config(MyButton.self, style: \.style, to: .card)
    .config(MyButton.self, style: \.backgroundColor, to: .green)
```

For example, with a card-type `MyButtonOption` setting the background color of the button to "blue", subsequent styles should override this, similar to a real `ButtonStyle`.

You can use `@Config` like this:

```swift
@Stylish
struct MyButtonOption {
    var style: any MyButtonStyle = .plain
    var backgroundColor: Color = .yellow
}

/// Card style button, It sets the background color of the button to blue until overridden by another style.
struct CardMyButtonStyle: MyButtonStyle {
    private struct Content: View {
        var body: some View {
            configuration.label
                .config(
                    MyButton.self, 
                    style: \.backgroundColor,
                    to: option.$backgroundColor(.blue)
                )
        }
        
        private let configuration: Configuration
        
        @Style(MyButton.self)
        var option
        
        init(_ configuration: Configuration) {
            self.configuration = configuration
        }
    }
    
    func makeBody(_ configuration: Configuration) -> some View {
        Content(configuration)
    }
}

@StyledComponent(MyButtonOption.self)
struct MyButton: View {
    private struct Content: View {
        var body: some View {
            Button {

            } label: {
                Text("Touch!")
                    .backgroundColor(option.backgroundColor)
            }
        }

        @Style(MyButton.self)
        var option
    }

    var body: some View {
        AnyView(
            option.style.makeBody(.init(
                label: .init(Content())
            ))
        )
    }
}
```

The `projectedValue` of the `@Config` property wrapper returns a function, which returns the value you pass in only if the property is not specified.

# Contribution
Any ideas, issues, opinions are welcome.

# License
`Stylish` is available under the MIT license. See the LICENSE file for more info.
