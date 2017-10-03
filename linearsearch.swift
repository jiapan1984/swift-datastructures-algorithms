func linearSearch<T:Equatable>(array:[T], e:T) -> Int? {
    for i in 0..<array.count {
        if array[i] == e {
            return i
        }
    }
    return nil
}

func linearSearch1<T: Equatable>(_ array:[T], _ object:T) -> Int? {
    for (index, obj) in array.enumerated() where obj == object {
        return index
    }
    return nil
}

let a = [1, 4, 9, 2, 10, 7]
print(linearSearch(array:a, e:7) ?? "nil")
print(linearSearch1(a, 10) ?? "nil")
print(linearSearch1(a, 6) ?? "nil")