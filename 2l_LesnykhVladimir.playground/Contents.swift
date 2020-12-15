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
func getArray() -> [Int] {
    var array = [Int]()
    for num in 1...100 {
        array.append(num)
    }
    return array
}

var arrayOfNumber = getArray()
print("Исходный массив:\n \(arrayOfNumber)\n")



// MARK: Задание 4
//

// Первый способ O(n^2)
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


//
// Второй способ O(n^3)
//
// for value in arrayOfNumber   = O(n)
// arrayOfNumber.remove         = O(n)
// arrayOfNumber.firstIndex     = O(n)
//
arrayOfNumber = getArray()
print("Исходный массив:\n \(arrayOfNumber)\n")

for value in arrayOfNumber where
    isEvenOrOddNumbers(number: value) || isDivisionBy3(number: value) {
        arrayOfNumber.remove(at: arrayOfNumber.firstIndex(of: value)!)
}
print("Новый массив:\n\(arrayOfNumber)\n")



// MARK: Задача 5*
//
func fibonacci(n: UInt) -> [Decimal]? {
    var arr = [Decimal]()
    
    switch n {
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
        for _ in 2...(n-1) {
            arr.append(arr[arr.endIndex-2] + arr[arr.endIndex-1])
        }
    }
    return arr
}

print("Фибоначчи 100: \n", fibonacci(n: UInt(100)) ?? "nil")



// MARK: Задание 6*
//
func getArrayPrimeOfNumber(n: UInt) -> [UInt] {
    
    var primes = [UInt?]()
    var arrayOutPut = [UInt]()

    primes.append(nil)  // вычеркнули 0
    primes.append(nil)  // вычеркнули 1

    for i in 2...n {
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

let primeArray = getArrayPrimeOfNumber(n: 542)
print("\nПервые \(primeArray.count) простых чисел: \n\(primeArray)\n")
