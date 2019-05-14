import UIKit

public final class BinaryNode<Element> {
    let value: Element
    
    var leftChild: BinaryNode<Element>?
    var rightChild: BinaryNode<Element>?
    
    public init(value: Element) {
        self.value = value
    }
    
    func addLeftChild(_ child: BinaryNode) {
        self.leftChild = child
    }
    
    func addRightChild(_ child: BinaryNode) {
        self.rightChild = child
    }
    
    func inOrderTraversal(_ visit: (BinaryNode) -> Void) {
        leftChild?.inOrderTraversal(visit)
        visit(self)
        rightChild?.inOrderTraversal(visit)
    }
    
    func preOrderTraversal(_ visit: (BinaryNode) -> Void) {
        visit(self)
        leftChild?.inOrderTraversal(visit)
        rightChild?.inOrderTraversal(visit)
    }
    
    func postOrderTraversal(_ visit: (BinaryNode) -> Void) {
        leftChild?.inOrderTraversal(visit)
        rightChild?.inOrderTraversal(visit)
        visit(self)
    }
}

var tree: BinaryNode<Int> = {
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five = BinaryNode(value: 5)
    let seven = BinaryNode(value: 7)
    let eight = BinaryNode(value: 8)
    let nine = BinaryNode(value: 9)
    
    seven.addLeftChild(five)
    seven.addRightChild(eight)
    
    five.addLeftChild(zero)
    five.addRightChild(one)
    
    eight.addRightChild(nine)
    
    return seven
}()

example(of: "in Order") {
    tree.inOrderTraversal { node in
        print(node.value)
    }
}

example(of: "pre Order") {
    tree.preOrderTraversal { node in
        print(node.value)
    }
}

example(of: "post Order") {
    tree.postOrderTraversal { node in
        print(node.value)
    }
}

