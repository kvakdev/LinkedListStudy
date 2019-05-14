import Foundation

public func example(of title: String, action: () -> ()) {
    print("----\(title)----")
    action()
    print("\n")
}
