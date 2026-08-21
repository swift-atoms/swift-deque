public import Buffer_Protocol_Primitives
public import Queue_DoubleEnded_Primitives
public import Store_Protocol_Primitives

public typealias Deque<S: Store.`Protocol` & Buffer.`Protocol` & ~Copyable> = __QueueDoubleEnded<S>
