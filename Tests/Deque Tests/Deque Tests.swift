import Deque
import Testing

@Suite
struct `Deque Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `the double-ended queue wraps and releases its store`() {
        var d = Deque<Int>(store: 1)
        d = Deque(store: 2)
        let store = d.take()
        #expect(store == 2)
    }
}
