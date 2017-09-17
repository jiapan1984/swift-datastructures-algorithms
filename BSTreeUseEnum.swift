//: Binary Search Tree implement by enum

enum BSTree<Element: Comparable> {
    case empty
    indirect case node(Element, left: BSTree<Element>, right: BSTree<Element>)
}

extension BSTree {
    func inserting(_ newElement: Element) -> BSTree<Element> {
        switch self {
        case .empty:
            return .node(newElement, left: .empty, right: .empty)
        case let .node(element, left, right):
            if element < newElement {
                return .node(element, left: left, right: right.inserting(newElement))
            } else {
                return .node(element, left: left.inserting(newElement), right: right)
            }
        }
    }
    
    mutating func insert(_ newElement: Element) {
        self = inserting(newElement)
    }
    
    func contains(_ element: Element) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(member, left, right):
            if member == element {
                return true
            } else if member < element {
                return right.contains(element)
            }
            else {
                return left.contains(element)
            }
        }
    }
}

extension BSTree: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(element, .empty, .empty):
            return "(\(element))"
        case let .node(element, left, right):
            return "(\(left) \(element) \(right))"
        }
    }
}

let tree = BSTree<Int>.empty
let t = tree.inserting(3).inserting(5).inserting(2).inserting(9).inserting(1)
print(t)
print("t.contains(2) = \(t.contains(2))")
print("t.contains(1) = \(t.contains(1))")