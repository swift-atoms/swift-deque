import Deque
import Index
import Memory_Small
import Queue_DoubleEnded_Small_Primitive
import Queue_Primitive
import Testing

@Suite
struct `Deque Small Door Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `the door resolves and is FIFO across the inline→heap spill (byte budget)`() {

        var d = Queue<Int>.DoubleEnded.Small<64>(minimumCapacity: 4)
        let empty = d.isEmpty
        #expect(empty)

        (1...16).forEach { value in
            d.push(value, to: .back)
        }
        #expect(d.count == Index<Int>.Count(16))

        var seen: [Int] = []
        while let x = d.pop(from: .front) { seen.append(x) }
        #expect(seen == Array(1...16))
    }

    @Test
    func
        `the door supports both ends + the growable family surface (push / pop / reserve / clear / clone)`()
    {
        var d = Queue<Int>.DoubleEnded.Small<64>()
        d.push(1, to: .back)
        d.push(2, to: .back)
        d.push(0, to: .front)

        #expect(d.pop(from: .front) == 0)
        #expect(d.pop(from: .back) == 2)
        #expect(d.count == Index<Int>.Count(1))

        d.reserve(Index<Int>.Count(32))
        #expect(d.capacity >= Index<Int>.Count(32))

        var copy = d.clone()
        copy.push(9, to: .back)
        #expect(d.count == Index<Int>.Count(1))
        #expect(copy.count == Index<Int>.Count(2))

        d.clear()
        let cleared = d.isEmpty
        #expect(cleared)
    }

    @Test
    func
        `the door is reachable from a MOVE-ONLY element and tears down exactly once (M1 restatement)`()
    {

        DequeSmallProbe.reset()
        do {
            var d = Queue<DequeSmallItem>.DoubleEnded.Small<64>(minimumCapacity: 2)
            d.push(DequeSmallItem(1), to: .back)
            d.push(DequeSmallItem(2), to: .back)
            d.push(DequeSmallItem(0), to: .front)
            #expect(d.count == Index<DequeSmallItem>.Count(3))

            if let front = d.pop(from: .front) {
                #expect(front.id == 0)
            } else {
                Issue.record("expected the front element")
            }
        }

        #expect(DequeSmallProbe.destroyedSorted == [0, 1, 2])
    }
}

private struct DequeSmallItem: ~Copyable {
    let id: Int
    init(_ id: Int) { self.id = id }
    deinit { DequeSmallProbe.recordDestroy(id) }
}

private enum DequeSmallProbe {
}

extension DequeSmallProbe {

    nonisolated(unsafe) static var _destroyed: [Int] = []
    static func reset() { unsafe _destroyed = [] }
    static func recordDestroy(_ id: Int) { unsafe _destroyed.append(id) }
    static var destroyedSorted: [Int] { unsafe _destroyed.sorted() }
}
