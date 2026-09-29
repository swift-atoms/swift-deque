public import Buffer
public import Buffer_Ring_Primitive
public import Memory_Allocator
public import Memory
public import Queue_Primitive
public import Storage
public import Store

extension __Queue where S: Store.`Protocol` & ~Copyable {

    public typealias DoubleEnded =
        __QueueDoubleEnded<
            Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<S.Element>>.Ring
        >
}
