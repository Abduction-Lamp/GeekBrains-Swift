//
// Лесных Владимир
//

import PlaygroundSupport


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
print(arrayOfNumber)

