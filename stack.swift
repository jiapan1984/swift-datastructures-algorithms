//: Playground - noun: a place where people can play

import Cocoa

struct Stack<Item> {
    var items = [Item]()
    mutating func push(_ item:Item){
        items.append(item)
    }
    mutating func pop() -> Item? {
        if items.isEmpty {
            return nil
        }
        return items.removeLast()
    }
    func peek() -> Item? {
        if items.isEmpty {
            return nil
        }
        return items.last
    }
    var isEmpty:Bool {
        return items.isEmpty
    }
    
    mutating func clear() {
        items = [Item]()
    }
}

func parenthesesCheck(_ a:Character, _ b:Character) -> Bool {
    switch (a, b) {
    case ("{", "}"), ("[", "]"), ("(", ")"):
        return true
    default:
        return false
    }
}

func parenthesesChecker(_ str:String) -> Bool {
    var st = Stack<Character>()
    for char in str.characters {
        switch char {
        case "{", "(", "[":
            st.push(char)
        case "}", ")", "]":
            guard let top = st.pop() else {
                return false
            }
            if !parenthesesCheck(top, char) {
                return false
            }
        default :
            break
        }
    }
    if st.isEmpty {
        return true
    }
    return false
}
var str1 = "{{{   }}}"
var str2 = "{[ [(fdsfkk )]{kkk } kk]}"
var str3 = "{[ [(fdsfkk )](((){kkk } kk]}"
print("str: \(str1), result: \(parenthesesChecker(str1))")
print("str: \(str2), result: \(parenthesesChecker(str2))")
print("str: \(str3), result: \(parenthesesChecker(str3))")
