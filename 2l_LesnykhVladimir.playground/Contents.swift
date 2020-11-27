//
// Лесных Владимир
//

import PlaygroundSupport


// Задание 1
//
func isEvenOrOddNumbers(namber: Int) -> Bool {
    return ((namber % 2) == 0) ? true : false
}

if isEvenOrOddNumbers(namber: 7) {
    print("Число четное")
} else {
    print("Число нечетное")
}


// Задание 2
//
func isDivisionBy3(namber: Int) -> Bool {
    return ((namber % 3) == 0) ? true : false
}

if isDivisionBy3(namber: 15) {
    print("Число делется на 3 без остаткa")
} else {
    print("Число на 3 без остатка не делится")
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

var arrayOfNamber = getArray()
print(arrayOfNamber)
