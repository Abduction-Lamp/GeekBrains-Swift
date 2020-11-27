//
// Лесных Владимир
//

import PlaygroundSupport


// Задание 1
//
func isEvenOrOddNumbers(namber: Int) {
    if (namber % 2) == 0 {
        print("Число \(namber) - четное")
    } else {
        print("Число \(namber) - нечетное")
    }
}

isEvenOrOddNumbers(namber: 7)
isEvenOrOddNumbers(namber: 4)



// Задание 2
//
func isDivisionBy3(namber: Int) {
    if (namber % 3) == 0 {
        print("Число \(namber) делется на 3 без остатко, результат от деление \(namber / 3)")
    } else {
        print("Число \(namber) на 3 без остатка не делится, остаток от деления \(namber % 3)")
    }
}

isDivisionBy3(namber: 12)
isDivisionBy3(namber: 13)
