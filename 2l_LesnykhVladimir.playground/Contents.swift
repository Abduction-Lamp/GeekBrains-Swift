//
//  main.swift
//  Владимир Лесных
//
//

import Foundation


// MARK: Задание 1
//
func isEvenOrOddNumbers(number: Int) -> Bool {
    return ((number % 2) == 0) ? true : false
}

// MARK: Задание 2
//
func isDivisionBy3(number: Int) -> Bool {
    return ((number % 3) == 0) ? true : false
}


// MARK: Задание 3
//
func getArray(size: UInt) -> [Int] {
    var array = [Int]()
    for num in 1...size {
        array.append(Int(num))
    }
    return array
}

var arrayOfNumber = getArray(size: 100)
print("Исходный массив:\n \(arrayOfNumber)")



// MARK: Задание 4
//

// Первый способ    O(n^2)
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


// Второй способ (в стиле Swift)    O(n^3)
//
// for value in arrayOfNumber       = O(n)
// arrayOfNumber.remove             = O(n)
// arrayOfNumber.firstIndex         = O(n)
//
arrayOfNumber = getArray(size: 100)
print("Исходный массив:\n\(arrayOfNumber)")

for value in arrayOfNumber where
    isEvenOrOddNumbers(number: value) || isDivisionBy3(number: value) {
        arrayOfNumber.remove(at: arrayOfNumber.firstIndex(of: value)!)
}
print("Новый массив:\n\(arrayOfNumber)\n")



// MARK: Задача 5*  Фибоначчи
//
func fibonacci(size: UInt) -> [Decimal]? {
    var arr = [Decimal]()
    
    switch size {
    case 0:
        return nil
    case 1:
        arr.append(0)
    case 2:
        arr.append(0)
        arr.append(1)
    default:
        arr.append(0)
        arr.append(1)
        for _ in 2..<size {
            arr.append(arr[arr.endIndex-2] + arr[arr.endIndex-1])
        }
    }
    return arr
}

print("Фибоначчи 100: \n", fibonacci(size: UInt(100)) ?? "nil")



// MARK: Задание 6*     Решето Эратосфена
//
func getArrayPrimeOfNumber(until: UInt) -> [UInt] {
    
    var primes = [UInt?]()
    var arrayOutPut = [UInt]()

    primes.append(nil)  // вычеркнули 0
    primes.append(nil)  // вычеркнули 1

    for i in 2...until {
        primes.append(i)
    }

    for (index, number) in primes.enumerated() where number != nil {
        for i in stride(from: (index * 2), to: primes.count, by: index) where primes[i] != nil {
            primes[i] = nil
        }
    }
    
    for prime in primes where prime != nil {
        arrayOutPut.append(prime!)
    }
    
    return arrayOutPut
}

let primeArray = getArrayPrimeOfNumber(until: 542)
print("\n\(primeArray.count) первых простых чисел: \n\(primeArray)\n")
