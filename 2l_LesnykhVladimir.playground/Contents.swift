//
// Лесных Владимир
//

import PlaygroundSupport
import Foundation


// Задание 1
//
func isEvenOrOddNumbers(number: Int) -> Bool {
    return ((number % 2) == 0) ? true : false
}


// Задание 2
//
func isDivisionBy3(number: Int) -> Bool {
    return ((number % 3) == 0) ? true : false
}


// Задание 3
//
func getArray() -> [Int] {
    var array = [Int]()
    for num in 1...100 {
        array.append(num)
    }
    return array
}

var arrayOfNumber = getArray()
print("Исходный массив:\n \(arrayOfNumber)\n")


// Задание 4
//
var i = 0
while i < arrayOfNumber.count {
    if isEvenOrOddNumbers(number: arrayOfNumber[i]) {
        arrayOfNumber.remove(at: i)
        continue
    }
    if isDivisionBy3(number: arrayOfNumber[i]) {
        arrayOfNumber.remove(at: i)
        continue
    }
    i += 1
}

print("Новый массив:\n\(arrayOfNumber)\n")


// Второй способ
//
// Но на сколько я понял сложность это алгоритма выше
// for value in arrayOfNumber   = O(n)
// arrayOfNumber.remove         = O(n)
// arrayOfNumber.firstIndex     = O(n)
//                        ИТОГО = O(n^3)
//
// в первом способое получаеться  O(n^2)
//
arrayOfNumber = getArray()
print("Исходный массив:\n \(arrayOfNumber)\n")

for value in arrayOfNumber {
    if isEvenOrOddNumbers(number: value) {
        arrayOfNumber.remove(at: arrayOfNumber.firstIndex(of: value)!)
        continue
    }
    if isDivisionBy3(number: value) {
        arrayOfNumber.remove(at: arrayOfNumber.firstIndex(of: value)!)
    }
}

print("Новый массив:\n\(arrayOfNumber)\n")
