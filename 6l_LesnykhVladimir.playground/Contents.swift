//
 //  Домашнее задание №6
 //  Лесных Владимир
 //
 //

import Foundation

struct Queue<T> {
    
    var container = [T]()
    var count: Int {
        return container.count
    }
    
    mutating func push(_ element: T) {
        container.append(element)
    }
    
    mutating func pop() -> T? {
        let element = container.first
        if element != nil {
            container.removeFirst()
        }
        return element
    }
    
    subscript(_ index: Int) -> T? {
        var element: T? = nil
        if index <= count {
            element = container[index]
        }
        return element
    }
}

extension Queue : CustomStringConvertible {
    var description: String {
        var str = ""
        if count == 0 {
            str = "Очередь пустая"
        } else {
            str = "Queue<\(type(of: container.first))>:\n" + container.description
        }
        return str
    }
}


// MARK: Работа с очередью
//
var queue = Queue<Int>()

for i in 0...9 {
    queue.push(i*100)
}
print(queue)

var index = 7
if let element = queue[index] {
    print("Queue[\(index)] = \(element)")
} else {
    print("Queue[\(index)] = nil")
}

index = 70
if let element = queue[index] {
    print("Queue[\(index)] = \(element)")
} else {
    print("Queue[\(index)] = nil")
}

while queue.count > 0 {
    print(queue.pop()!)
}
print(queue)
