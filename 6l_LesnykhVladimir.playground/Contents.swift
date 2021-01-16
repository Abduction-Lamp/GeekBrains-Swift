//
 //  Домашнее задание №6
 //  Лесных Владимир
 //
 //

import Foundation

// MARK: FIFO
//
struct Queue<T> {
    
    private var container = [T]()
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
    
    // MARK: Замыкания
    //
    func filter(_ predicate: (T) -> Bool) -> Queue<T> {
        var output = Queue<T>()
        for element in container where predicate(element) {
            output.push(element)
        }
        return output
    }
    
    func map(_ transform: (T) -> T) -> Queue<T> {
        var output = Queue<T>()
        for element in container {
            output.push(transform(element))
        }
        return output
    }
        
    // MARK: Сабскрипты
    //
    subscript(_ index: UInt) -> T? {
        var element: T? = nil
        if index <= count {
            element = container[Int(index)]
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
            str = "Очередь<\(type(of: container.first))> из \(count) элементов:\n" + container.description
        }
        return str
    }
}


// MARK: Работа с очередью Int
//
var queueInt = Queue<Int>()

for i in 0...9 {
    queueInt.push(i * 100)
}
print(queueInt)
print("")

// subscript
var index: UInt = 7
if let element = queueInt[index] {
    print("Queue[\(index)] = \(element)")
} else {
    print("Queue[\(index)] = nil")
}

index = 70
if let element = queueInt[index] {
    print("Queue[\(index)] = \(element)")
} else {
    print("Queue[\(index)] = nil")
}
print("")


// filter + map
print(queueInt.filter{ $0 >= 500 }.map{ $0 + 1 })
print("")


while queueInt.count > 0 {
    print(queueInt.pop()!, terminator: " ")
}
print("")
print(queueInt)
print("\n")


// MARK: Работа с очередью String
//
var queueString = Queue<String>()

queueString.push("Привет")
queueString.push(", ")
queueString.push("мир!")

print(queueString.map{ $0.uppercased() })
print("")
print(queueString.filter{ $0.lowercased() == "привет" })
print("")
print(queueString.filter{ $0 == "привет" })
