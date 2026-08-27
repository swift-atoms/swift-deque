@_documentation(visibility: public)
@frozen
public struct __QueueDoubleEnded<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var store: S

    public enum Position: Sendable, Equatable {
        case front
        case back
    }

    @inlinable
    public init(store: consuming S) {
        self.store = store
    }

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __QueueDoubleEnded: Copyable where S: Copyable {}

extension __QueueDoubleEnded: Sendable where S: Sendable & ~Copyable {}
