import Foundation

public enum CountingAction: String, Hashable, CaseIterable, Codable {
    case increment
    case decrement
}

public struct Counter<CountType: FixedWidthInteger, StepType: UnsignedInteger & FixedWidthInteger> {

    public let step: StepType
    public let minCount: CountType?
    public let maxCount: CountType?

    public var count: CountType = .zero
    public var isEnabled: Bool = true

    public init(
        step: StepType,
        minCount: CountType?,
        maxCount: CountType?,
        count: CountType,
        isEnabled: Bool
    ) {
        self.step = max(1, step)
        self.minCount = minCount
        self.maxCount = maxCount
        self.isEnabled = isEnabled
        self.count = min(max(safeMinCount, count), safeMaxCount)
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
        isEnabled && (count + CountType(step) <= safeMaxCount)
    }

    /// Decrementing is enabled when the counter itself is enabled **and** decrementing
    /// the counter's current value will not go below its minimum value.
    public var isDecrementingEnabled: Bool {
        isEnabled && (count >= safeMinCount + CountType(step))
    }

    /// Defaults to `.min`.
    public var safeMinCount: CountType {
        minCount ?? .min
    }

    /// Defaults to `.max`.
    public var safeMaxCount: CountType {
        maxCount ?? .max
    }

}

extension Counter: Equatable where CountType: Equatable, StepType: Equatable {}
extension Counter: Hashable where CountType: Hashable, StepType: Hashable {}
extension Counter: Codable where CountType: Codable, StepType: Codable {}
