//: Binary Search Tree implement by class, support generic/iterator. 

import Cocoa

class TreeNode<Key:Comparable>{
    var key:Key
    var parent:TreeNode?
    var left:TreeNode?
    var right:TreeNode?
    
    init(_ key:Key) {
        self.key = key
        left = nil
        right = nil
    }
    deinit {
        print("deinit \(key)")
    }
}

struct BSTreeIterator<Key:Comparable> : IteratorProtocol {
    var curNode:TreeNode<Key>?
    
    init(_ first:TreeNode<Key>?) {
        curNode = first
    }
    mutating func next() -> Key? {
        guard let node = curNode else {
            return nil
        }
        curNode = BSTree.nextNode(curNode: node)
        return node.key
    }
}

class BSTree<Key:Comparable> : Sequence{
    var root:TreeNode<Key>?
    var count:Int = 0
    
    func insert(_ key:Key) {
        if root == nil {
            root = TreeNode<Key>(key)
            return
        }
        var node = root
        var parent:TreeNode<Key>! = root
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
        node = TreeNode<Key>(key)
        count += 1
        if parent.key > key {
            parent.left = node
        }else {
            parent.right = node
        }
        node!.parent = parent
    }
    
    func makeIterator() -> BSTreeIterator<Key> {
        let first = firstNode()
        return BSTreeIterator<Key>(first)
    }
    
    func lookup(_ key:Key) -> Bool {
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
    
    func traverse(_ callback:(_:Key) -> Void) {
        traverseNode(root, callback)
    }
    
    func traverseNode(_ node:TreeNode<Key>?, _ callback:(_:Key) -> Void) {
        if node == nil {
            return
        }
        traverseNode(node!.left, callback)
        callback(node!.key)
        traverseNode(node!.right, callback)
        
    }
    
    func firstNode() -> TreeNode<Key>?{
        return BSTree.firstNode(curNode: root)
    }
    
    static func firstNode(curNode:TreeNode<Key>?) -> TreeNode<Key>? {
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
    
    static func nextNode(curNode:TreeNode<Key>) -> TreeNode<Key>? {
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
    
    func lastNode() -> TreeNode<Key>? {
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
    
    func min() -> Key? {
        guard let node = firstNode() else {
            return nil
        }
        return node.key
    }
    
    func max() -> Key? {
        guard let node = lastNode() else {
            return nil
        }
        return node.key
    }
    func contains(_ element: Key) -> Bool {
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

print("tree.contains(5) = \(tree.contains(5))")






