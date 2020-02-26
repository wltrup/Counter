import Foundation

public enum CountingAction: String, Hashable, CaseIterable, Codable {
    case increment
    case decrement
}

public struct Counter<CountType: FixedWidthInteger, StepType: UnsignedInteger & FixedWidthInteger> {

    public let step: StepType
    public let minCount: CountType
    public let maxCount: CountType

    public var count: CountType = .zero
    public var isEnabled: Bool = true

    public init(
        step: StepType = 1, // max(1, step)
        minCount: CountType = .zero,
        maxCount: CountType = .max,
        count: CountType = 0, // clamped to the range [minCount, maxCount]
        isEnabled: Bool = true
    ) {
        self.step = max(1, step)
        self.minCount = minCount
        self.maxCount = maxCount
        self.count = min(max(minCount, count), maxCount)
        self.isEnabled = isEnabled
    }

    /// Increments the counter by its `step` value, if incrementing is enabled.
    /// Otherwise, does nothing.
    public mutating func increment() {
        guard isIncrementingEnabled else { return }
        count += CountType(step)
    }

    /// Decrements the counter by its `step` value, if decrementing is enabled.
    /// Otherwise, does nothing.
    public mutating func decrement() {
        guard isDecrementingEnabled else { return }
        count -= CountType(step)
    }

    /// Incrementing is enabled when the counter itself is enabled **and** incrementing
    /// the counter's current value will not go above its maximum value.
    public var isIncrementingEnabled: Bool {
        isEnabled && (count <= maxCount - CountType(step))
    }

    /// Decrementing is enabled when the counter itself is enabled **and** decrementing
    /// the counter's current value will not go below its minimum value.
    public var isDecrementingEnabled: Bool {
        isEnabled && (count >= minCount + CountType(step))
    }

}

extension Counter: Equatable where CountType: Equatable, StepType: Equatable {}
extension Counter: Hashable where CountType: Hashable, StepType: Hashable {}
extension Counter: Codable where CountType: Codable, StepType: Codable {}
