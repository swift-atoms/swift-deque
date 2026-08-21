public import Buffer_Primitive
public import Buffer_Ring_Bounded_Primitive
public import Buffer_Ring_Primitive
public import Index_Primitives
public import Memory_Allocator_Primitive
public import Memory_Allocator_Protocol_Primitives
public import Memory_Heap_Primitives
public import Ownership_Shared_Primitive
public import Storage_Contiguous_Primitives
public import Store_Protocol_Primitives

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

extension __QueueDoubleEnded where S: Store.`Protocol` & ~Copyable {

    public typealias Index = Index_Primitives.Index<S.Element>
}

extension __QueueDoubleEnded where S: ~Copyable {

    @inlinable
    public init<E: ~Copyable, Resource: Memory.Growable & ~Copyable>(
        minimumCapacity: Index_Primitives.Index<E>.Count = .zero
    )
    where S == Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Ring {
        self.init(store: S(minimumCapacity: minimumCapacity))
    }

    @inlinable
    public init<E: ~Copyable>(capacity: Index_Primitives.Index<E>.Count)
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring.Bounded {
        self.init(store: S(minimumCapacity: capacity))
    }

    @inlinable
    public init<E>(minimumCapacity: Index_Primitives.Index<E>.Count = .zero)
    where
        S == Ownership.Shared<E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring>
    {
        self.init(
            store: Ownership.Shared(
                Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring(
                    minimumCapacity: minimumCapacity
                )
            )
        )
    }

    @inlinable
    public init<E: ~Copyable>(minimumCapacity: Index_Primitives.Index<E>.Count = .zero)
    where
        S == Ownership.Shared<E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring>
    {
        self.init(
            store: Ownership.Shared(
                Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring(
                    minimumCapacity: minimumCapacity
                )
            )
        )
    }

    @inlinable
    public init<E>(capacity: Index_Primitives.Index<E>.Count)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring.Bounded
        >
    {
        self.init(
            store: Ownership.Shared(
                Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring.Bounded(
                    minimumCapacity: capacity
                )
            )
        )
    }

    @inlinable
    public init<E: ~Copyable>(capacity: Index_Primitives.Index<E>.Count)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring.Bounded
        >
    {
        self.init(
            store: Ownership.Shared(
                Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring.Bounded(
                    minimumCapacity: capacity
                )
            )
        )
    }
}
