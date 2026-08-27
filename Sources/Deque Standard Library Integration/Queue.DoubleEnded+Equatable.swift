public import Deque

extension __QueueDoubleEnded: Equatable where S: Equatable {

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.store == rhs.store
    }
}

extension __QueueDoubleEnded: Hashable where S: Hashable {

    @inlinable
    public func hash(into hasher: inout Hasher) {
        store.hash(into: &hasher)
    }
}
