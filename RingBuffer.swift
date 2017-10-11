// 一个简单的环形缓冲区数据结构

#if swift(>=4.0)
print("Hello, Swift 4!")

public struct RingBuffer<T> {
    fileprivate var array:[T?]
    fileprivate var readIndex = 0
    fileprivate var writeIndex = 0
    public init(_ count: Int) {
        array = [T?](repeating:nil, count:count)
    }
    public mutating func write(_ element: T) -> Bool {
        if isFull {
            return false
        } else {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        }
    }
    public mutating func read() -> T? {
        if !isEmpty {
            let elem = array[readIndex % array.count]
            array[readIndex % array.count] = nil
            readIndex += 1
            return elem
        } else {
            return nil
        }
    }
    public var isFull: Bool {
        return (writeIndex - readIndex) == array.count
    }
    public var isEmpty: Bool {
        return writeIndex == readIndex
    }
}

var a = RingBuffer<Int>(5)
for i in 1...5 {
    _ = a.write(i)
}
assert(a.write(6) == false) 
assert(a.write(7) == false) 
assert(a.read() == 1)
assert(a.read() == 2)
assert(a.write(7)) 
assert(a.write(8)) 
assert(a.read() == 3)
assert(a.read() == 4)
assert(a.write(9)) 
assert(a.write(10))   
assert(a.read() == 5)
assert(a.read() == 7)
assert(a.read() == 8)
assert(a.read() == 9)
assert(a.read() == 10)
assert(a.read() == nil)
#endif

