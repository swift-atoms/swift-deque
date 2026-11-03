# swift-deque

Use this package when you need a queue that pushes, pops and peeks at both ends, including for move-only elements. Start from `Queue<E>.DoubleEnded`, a growable heap ring, or `Queue<E>.DoubleEnded.Small<n>` to keep the first elements inline. To choose the storage yourself, use `Deque<S>` (`__QueueDoubleEnded<S>`) with `S` set to one of four columns: `Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring` (growable), `Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Ring.Bounded` (fixed capacity), or either one wrapped in `Ownership.Shared<E, …>` (copy-on-write). If you only push at one end and pop at the other, use `Queue<E>` from swift-queue.

## Laws

- Order runs front to back. An element pushed to `.front` is the next one popped from `.front`. Popping from `.back` returns the most recent push to `.back` that is still in the queue. `forEach` and `drain` visit elements from front to back, and `drain` leaves the queue empty.
- `pop(from:)`, `take(from:)` and `peek(at:)` return `nil` on an empty queue and do nothing else. `take(from:)` behaves exactly like `pop(from:)`.
- A bounded column never grows. Pushing at either end of a full bounded column throws, leaves the contents unchanged and destroys the rejected element. Once an element is popped, the freed slot can be pushed again. `clear()` on a bounded column always keeps its capacity.
- A growable column's `clear(keepingCapacity:)` keeps the capacity by default. With `false`, it releases the storage. After `reserve(_:)`, the capacity is at least the amount requested.
- Copies of an `Ownership.Shared` column share storage until one of them is mutated. Pushes, pops, `reserve(_:)` and `drain` first detach the copy being changed, so sibling copies never see the change. `clear` on a shared column swaps in new storage and leaves siblings untouched.
- `clone()` always returns an independent queue, on every column, including the shared ones.
- Equality and hashing come from the store. On the shared growable column, two queues holding the same elements in the same order are equal, whatever capacity each was created with.
- Each element is destroyed exactly once. A popped element moves to the caller. When the queue is destroyed, the elements still in it are destroyed with it, through the shared box on the shared columns.
- `Queue<E>.DoubleEnded.Small<n>` stores elements inline within an `n`-byte budget. Past that budget it moves them to the heap and keeps their front-to-back order.
