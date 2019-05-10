import UIKit

public final class RingBuffer<Element> {
    var storage: [Element?]
    var readIndex = 0
    var writeIndex = 0
    
    init(capacity: Int) {
        storage = [Element?](repeating: nil, count: capacity)
    }
    
    func read() -> Element? {
        guard !isEmpty else { return nil }
        
        let value = storage[readIndex % storage.count]
        readIndex += 1
        
        return value
    }
    
    func write(value: Element) {
        storage[writeIndex % storage.count] = value
        writeIndex += 1
    }
    
    var isEmpty: Bool {
        return readIndex >= writeIndex
    }
}

var buffer = RingBuffer<Int>(capacity: 4)
buffer.write(value: 1)
buffer.write(value: 2)
buffer.write(value: 3)
buffer.write(value: 4)
buffer.write(value: 5)

buffer.read()
buffer.read()
buffer.read()
buffer.read()


