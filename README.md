# Counter
![](https://img.shields.io/badge/platforms-iOS%2010%20%7C%20tvOS%2010%20%7C%20watchOS%204%20%7C%20macOS%2010.14-red)
[![Xcode](https://img.shields.io/badge/Xcode-11-blueviolet.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wltrup/Counter)
![GitHub](https://img.shields.io/github/license/wltrup/Counter)

## What

**Counter** is a Swift Package Manager package for iOS/tvOS (10.0 and above), watchOS (4.0 and above), and macOS (10.14 and above), under Swift 5.0 and above,  defining a model type to represent an integer counter:

```swift
public enum CountingAction: String, Hashable, CaseIterable, Codable {
    case increment
    case decrement
}

public struct Counter<CountType: FixedWidthInteger, StepType: UnsignedInteger & FixedWidthInteger> {

    public let step: StepType
    public let minCount: CountType
    public let maxCount: CountType

    public internal(set) var count: CountType
    public var isEnabled: Bool

    public init(
        step: StepType = 1, // max(1, step)
        minCount: CountType = .zero,
        maxCount: CountType = .max,
        count: CountType = .zero, // clamped to the range [minCount, maxCount]
        isEnabled: Bool = true
    )

    /// Increments the counter by its `step` value, if incrementing is enabled.
    /// Otherwise, does nothing.
    public mutating func increment()

    /// Decrements the counter by its `step` value, if decrementing is enabled.
    /// Otherwise, does nothing.
    public mutating func decrement()

    /// Incrementing is enabled when the counter itself is enabled **and** incrementing
    /// the counter's current value will not go above its maximum value.
    public var isIncrementingEnabled: Bool

    /// Decrementing is enabled when the counter itself is enabled **and** decrementing
    /// the counter's current value will not go below its minimum value.
    public var isDecrementingEnabled: Bool

}

extension Counter: Equatable where CountType: Equatable, StepType: Equatable {}
extension Counter: Hashable where CountType: Hashable, StepType: Hashable {}
extension Counter: Codable where CountType: Codable, StepType: Codable {}
```

Note that `minCount` need not be `.zero`. It can be as low as `.min`.

## Installation

**Counter** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## License

**Counter** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
