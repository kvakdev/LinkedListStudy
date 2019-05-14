import UIKit

public final class DoubleArrayQueue<Element> {
    private var left = [Element]()
    private var right = [Element]()
    
    @discardableResult
    func enqueue(value: Element) -> Bool {
        right.append(value)
        
        return true
    }
    
    func enqueueBatch(values: Element...) -> Bool {
        values.forEach { right.append($0) }
        
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

public final class TreeNode<Element> {
    private let value: Element
    private var childNodes = [TreeNode<Element>]()
    
    public init(value: Element) {
        self.value = value
    }
    
    public func addChild(_ node: TreeNode<Element>) {
        childNodes.append(node)
    }
    
    public func addChildren(_ nodes: TreeNode<Element>...) {
        nodes.forEach { childNodes.append($0) }
    }
    
    public func depthFirstTraversal(_ visit: (TreeNode<Element>) -> Void) {
        visit(self)
        
        childNodes.forEach { $0.depthFirstTraversal(visit) }
    }
    
    public func widthFirstTraversal(_ visit: (TreeNode<Element>) -> Void) {
        visit(self)
        
        var queue = DoubleArrayQueue<TreeNode<Element>>()
        self.childNodes.forEach { queue.enqueue(value: $0) }
        
        while let node = queue.dequeue() {
            visit(node)
            node.childNodes.forEach { queue.enqueue(value: $0) }
        }
    }
    
   
}

extension TreeNode where Element: Equatable {
    public func search(_ value: Element) -> TreeNode?  {
        var result: TreeNode?
        
        widthFirstTraversal { node in
            if node.value == value {
                result = node
            }
        }
        
        return result
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        return String(describing: value)
    }
}

public final class Tree<Element> {
    var rootNode: TreeNode<Element>
    
    public init(node: TreeNode<Element>) {
        self.rootNode = node
    }
    
    func depthFirstTraversal(_ visit: (TreeNode<Element>) -> Void) {
        rootNode.depthFirstTraversal(visit)
    }
    
    func widthFirstTraversal(_ visit: (TreeNode<Element>) -> Void) {
        rootNode.widthFirstTraversal(visit)
    }
}

var beverages = TreeNode(value: "beverages")
var hot = TreeNode(value: "hot")
var cold = TreeNode(value: "cold")
var tea = TreeNode(value: "tea")
var coffee = TreeNode(value: "coffee")
var green = TreeNode(value: "green")
var black = TreeNode(value: "black")
var herb = TreeNode(value: "herb")
var soda = TreeNode(value: "soda")

beverages.addChildren(cold, hot)
hot.addChildren(tea, coffee)
tea.addChildren(green, black, herb)
cold.addChild(soda)

let tree = Tree(node: beverages)
//tree.depthFirstTraversal { node in
//    print(node)
//}

tree.widthFirstTraversal { node in
    print(node)
}

if let resultOne = beverages.search("coffee") {
    print("found coffee node = \(resultOne)")
} else {
    print("found no coffee")
}

if let resultOne = beverages.search("whiskey") {
    print("found whiskey node = \(resultOne)")
} else {
    print("found no whiskey")
}
