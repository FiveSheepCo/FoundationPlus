# FoundationPlus

Welcome to **FoundationPlus**, an extensive Swift library designed to enhance and simplify your coding experience with a
range of utilities and extensions. This package extends the standard Swift Foundation library, adding functionalities
that are commonly needed but not present in the default implementation.

## Features

**FoundationPlus** offers a variety of features to streamline your Swift development:

- **Boolean Enhancements:** Adds a `.negated` property for more intuitive handling of boolean logic.
- **CGPoint Utilities:** Easy calculation of distances between points.
- **Character and String Constants:** Includes useful constants like `.space`, `.newline`, `.tab` on `Character`, and
  `.empty` for `String`.
- **Collection Extensions:** Introduces `.indexed` for Collections, yielding (Index, Element) pairs.
- **Date and Time Enhancements:** Simplifies date and time handling with methods like `dateOnly`,
  `timeIntervalUntilNow`, and convenient initializers.
- **Double Formatting:** Versatile `toFormattedString` method for `Double` types.
- **TimeInterval Extensions:** Includes units and components for more expressive time interval calculations.
- **Property Wrappers:** Offers a range of property wrappers like `EquatablePublished`, `BackgroundPublished`, and
  `SettingStorage` for more efficient state management.
- **Combine Publishers:** Introduces `Publishable` protocol and `PublishablePublisher` for more flexible data
  publishing.

And much more, with continuous additions and updates to enhance your Swift development workflow.

## Installation

You can easily integrate **FoundationPlus** into your Swift project using Swift Package Manager. Here's how:

1. In Xcode, select "File" > "Swift Packages" > "Add Package Dependency..."
2. Enter the repository URL: `https://github.com/FiveSheepCo/FoundationPlus.git`
3. Follow the on-screen instructions to complete the installation.

## Usage

To start using **FoundationPlus**, simply import the package into your Swift files:

```swift
import FoundationPlus
```

Then, you can directly access the new features and enhancements provided by the package.

## Related Packages

Also check out our other Swift packages:
- [SwiftUIElements]: SwiftUI components, extensions, and utilities for painless UI development.

## Contributions

We're always looking for ways to improve **FoundationPlus** and we welcome contributions. Whether it's a bug report, a
feature request, or a pull request, your input is invaluable to us.

## License

**FoundationPlus** is available under the MIT license. See the [LICENSE](LICENSE.md) file for more info.

<!-- Links -->

[FoundationPlus]: https://github.com/FiveSheepCo/FoundationPlus
[SwiftUIElements]: https://github.com/FiveSheepCo/SwiftUIElements
