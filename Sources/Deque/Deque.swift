public import Buffer_Protocol
public import Queue_DoubleEnded
public import Store_Protocol

public typealias Deque<S: Store.`Protocol` & Buffer.`Protocol` & ~Copyable> = __QueueDoubleEnded<S>
