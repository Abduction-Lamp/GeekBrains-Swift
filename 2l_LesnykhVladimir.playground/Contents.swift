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



// Задача 5*
//
func fibonacci(n: UInt) -> Decimal? {
    
    var previous: Decimal = Decimal(0)
    var current: Decimal = Decimal(0)
    var temp: Decimal = Decimal(0)
    
    switch n {
    case 0:
        return nil
    case 1:
        current = 0
    case 2:
        current = 1
    default:
        previous = 0
        current = 1
        for _ in 3...n {
            temp = current
            current += previous
            previous = temp
        }
    }
    return current
}

print("Фибоначчи 100: ", fibonacci(n: UInt(100)) ?? "nil")



// Задание 6*
//
func getArrayPrimeOfNumber(n: UInt) -> [UInt] {
    var primes = [UInt?]()
    var arrayOutPut = [UInt]()

    primes.append(nil)  // вычеркнули 0
    primes.append(nil)  // вычеркнули 1

    for i in 2...n {
        primes.append(i)
    }

    var p = 2
    while p < n {
        var i = p + p
        while i <= n  {
            primes[i] = nil
            i += p
        }
        p += 1
        while p <= n && primes[p] == nil {
            p += 1
        }
    }

    for prime in primes where prime != nil {
        arrayOutPut.append(prime!)
    }
    
    return arrayOutPut
}

print("\nПростые числа: \n\(getArrayPrimeOfNumber(n: 100)) \n")
