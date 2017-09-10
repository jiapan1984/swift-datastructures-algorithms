//:

import Cocoa

class TreeNode<Type:Comparable>{
    var key:Type
    var parent:TreeNode?
    var left:TreeNode?
    var right:TreeNode?
    
    init(_ key:Type) {
        self.key = key
        left = nil
        right = nil
    }
    deinit {
        print("deinit \(key)")
    }
}

struct BSTreeIterator<Type:Comparable> : IteratorProtocol {
    var curNode:TreeNode<Type>?
    
    init(_ first:TreeNode<Type>?) {
        curNode = first
    }
    mutating func next() -> Type? {
        guard let node = curNode else {
            return nil
        }
        curNode = BSTree.nextNode(curNode: node)
        return node.key
    }
}

class BSTree<Type:Comparable> : Sequence{
    var root:TreeNode<Type>?
    var count:Int = 0
    
    func insert(_ key:Type) {
        if root == nil {
            root = TreeNode<Type>(key)
            return
        }
        var node = root
        var parent:TreeNode<Type>! = root
        while node != nil {
            let node_key = node!.key
            parent = node
            if node_key == key {
                return
            } else if node_key > key {
                node = node!.left
            } else {
                node = node!.right
            }
        }
        node = TreeNode<Type>(key)
        count += 1
        if parent.key > key {
            parent.left = node
        }else {
            parent.right = node
        }
        node!.parent = parent
    }
    
    func makeIterator() -> BSTreeIterator<Type> {
        let first = firstNode()
        return BSTreeIterator<Type>(first)
    }
    
    func lookup(_ key:Type) -> Bool {
        var node = root
        while node != nil {
            let node_key = node!.key
            if node_key == key {
                return true
            } else if node_key > key {
                node = node!.left
            } else {
                node = node!.right
            }
        }
        return false
    }
    
    func traverse(_ callback:(_:Type) -> Void) {
        traverseNode(root, callback)
    }
    
    func traverseNode(_ node:TreeNode<Type>?, _ callback:(_:Type) -> Void) {
        if node == nil {
            return
        }
        traverseNode(node!.left, callback)
        callback(node!.key)
        traverseNode(node!.right, callback)
        
    }
    
    func firstNode() -> TreeNode<Type>?{
        return BSTree.firstNode(curNode: root)
    }
    
    static func firstNode(curNode:TreeNode<Type>?) -> TreeNode<Type>? {
        var node = curNode
        
        while node != nil {
            if let left = node!.left {
                node = left
            } else {
                return node
            }
        }
        return nil
    }
    
    static func nextNode(curNode:TreeNode<Type>) -> TreeNode<Type>? {
        var cn = curNode
        
        if let right = cn.right {
            return BSTree.firstNode(curNode: right)
        }
        
        while let parent = cn.parent {
            if parent.right != nil && parent.right! === cn {
                cn = cn.parent!
            } else {
                return cn.parent
            }
        }
        return nil
    }
    
    func lastNode() -> TreeNode<Type>? {
        var node = root
        while node != nil {
            if let right = node!.right {
                node = right
            } else {
                return node
            }
        }
        return nil
    }
    
    func min() -> Type? {
        guard let node = firstNode() else {
            return nil
        }
        return node.key
    }
    
    func max() -> Type? {
        guard let node = lastNode() else {
            return nil
        }
        return node.key
    }
    func contains(_ element: Type) -> Bool {
        return lookup(element)
    }
}


var strTree = BSTree<String>()
strTree.insert("dog")
strTree.insert("cat")
strTree.insert("fish")
for key in strTree {
    print("It's \(key)")
}

var tree = BSTree<Int>()
tree.insert(5)
tree.insert(6)
tree.insert(1)
tree.insert(2)
tree.insert(7)
tree.insert(8)
tree.insert(3)
tree.insert(4)
tree.insert(9)
for n in tree {
    print(n)
}

tree.contains(5)





