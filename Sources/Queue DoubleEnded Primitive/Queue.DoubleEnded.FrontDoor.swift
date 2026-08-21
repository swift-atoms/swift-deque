public import Buffer_Primitive
public import Buffer_Ring_Primitive
public import Memory_Allocator_Primitive
public import Memory_Heap_Primitives
public import Queue_Primitive
public import Storage_Contiguous_Primitives
public import Store_Protocol_Primitives

extension __Queue where S: Store.`Protocol` & ~Copyable {

    public typealias DoubleEnded =
        __QueueDoubleEnded<
            Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<S.Element>>.Ring
        >
}
