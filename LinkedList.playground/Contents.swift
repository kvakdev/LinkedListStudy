import UIKit

class Node<Value> {
    let value: Value
    var next: Node<Value>?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    func copy() -> Node<Value> {
        return Node<Value>(value: value, next: next)
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else { return "\(value)" }
        
        return "\(self.value) -> " + String(describing: next) + " "
    }
}

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    init() {}
    
    var isEmpty: Bool {
        return head == nil
    }
    
    mutating func push(value: Value) {
        if isEmpty {
            head = Node(value: value, next: nil)
            tail = head
        } else {
            let newNode = Node(value: value, next: head)
            head = newNode
        }
    }
    
    mutating func append(value: Value) {
        copyNodesIfNeeded()
        
        if isEmpty {
            push(value: value)
        } else {
            let newNode = Node(value: value, next: nil)
            tail?.next = newNode
            tail = newNode
        }
    }
    
    mutating func insert(_ value: Value, after node: Node<Value>) {
        copyNodesIfNeeded()
        
        guard node !== self.tail else {
            append(value: value)
            return
        }
    
        let newNode = Node(value: value, next: node.next)
        node.next = newNode
    }
    
    func node(at index: Int) -> Node<Value>? {
        var currentIndex = 0
        var currentNode = self.head
        
        while currentIndex != index && currentNode != nil {
            currentIndex += 1
            currentNode = currentNode?.next
        }
        
        return currentNode
    }
    
    public mutating func pop() -> Value? {
        copyNodesIfNeeded()
        
        let result = head?.value
        head = head?.next
        
        if isEmpty {
            tail = nil
        }
        
        return result
    }
    
    public mutating func removeLast() -> Value? {
        copyNodesIfNeeded()
        //1
        guard !isEmpty else { return nil }
        //2
        guard head?.next != nil else {
            return pop()
        }
        //3
        var currentNode = head
        var prevNode = head
        
        while let nextNode = currentNode?.next {
            prevNode = currentNode
            currentNode = nextNode
        }
        //4
        prevNode?.next = nil
        tail = prevNode
        
        return currentNode?.value
    }
    
    public mutating func remove(after node: Node<Value>) -> Value? {
        copyNodesIfNeeded()
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        if isEmpty {
            return "Empty list"
        }
        
        return String(describing: self.head!)
    }
}

extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Value>?
        
        public init(node: Node<Value>?) {
            self.node = node
        }
        
        public static func < (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            guard lhs.node !== rhs.node else {
                return false
            }
            
            let followingNodes = sequence(first: lhs.node) { $0?.next }
            return followingNodes.contains { $0?.next === rhs.node }
        }
        
        static public func == (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
    }
    
    var startIndex: LinkedList<Value>.Index {
        return Index(node: head)
    }
    
    var endIndex: LinkedList<Value>.Index {
        return Index(node: tail?.next)
    }
    
    func index(after i: LinkedList<Value>.Index) -> LinkedList<Value>.Index {
        return Index(node: i.node?.next)
    }
    
    subscript(position: LinkedList<Value>.Index) -> Value {
        return position.node!.value
    }
}

extension LinkedList {
    
    mutating func copyNodesIfNeeded() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
 
        print("List before copying = \(self)")
        
        var newNode = Node(value: oldNode.value)
        head = newNode
        
        while let nextOldNode = oldNode.next {
            let new = Node(value: nextOldNode.value)
            
            newNode.next = new
            
            newNode = new
            oldNode = nextOldNode
        }
        
        tail = newNode
        
        print("List after copying = \(self)")
    }
}

var list = LinkedList<Int>()

(0...3).forEach { list.append(value: $0) }

print(list)
print("\n")

var list2 = list

list2.append(value: 10000)
list.append(value: 0)

print(list)
print(list2)
print("\n")

list2.push(value: -11)
list.push(value: 999)

print(list)
print(list2)
print("\n")

