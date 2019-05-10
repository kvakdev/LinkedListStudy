import UIKit

public final class DoubleArrayQueue<Element> {
    private var left = [Element]()
    private var right = [Element]()
    
    @discardableResult
    func enqueue(value: Element) -> Bool {
        right.append(value)
        
        return true
    }
    
    func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        
        return left.popLast()
    }
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    
    var count: Int {
        return left.count + right.count
    }
}

var queue = DoubleArrayQueue<Int>()

queue.enqueue(value: 1)
queue.enqueue(value: 2)
queue.enqueue(value: 3)
queue.enqueue(value: 4)

let c = queue.count

queue.dequeue()
queue.dequeue()
queue.dequeue()

let l = queue.count

