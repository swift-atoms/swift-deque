public import Buffer
public import Queue_DoubleEnded
public import Store

public typealias Deque<S: Store.`Protocol` & Buffer.`Protocol` & ~Copyable> = __QueueDoubleEnded<S>
