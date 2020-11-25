//
//  Лесных Владимир
//
//  Created by Владимир on 24.11.2020.
//

import Foundation


// ЗАДАНИЕ 1
//
// ax^2 + bx + c = 0
//
// in: a = 1, b = 5, c = 4  out: x1 = -1; x2 = -4
// in: a = 1, b = 2, c = 1  out: x1 = x2 = -1

let a = Double(1)
let b = Double(5)
let c = Double(4)

print("1. Квадратное уравнение: \(a)x^2 + \(b)x + \(c) = 0\n")

var x1, x2: Double

var discriminant = b * b - 4 * a * c

if a != 0 {
    if discriminant < 0 {
        print("Корней на множестве действительных чисел нет \n")
    } else if discriminant == 0 {
        x1 = (-b) / (2 * a)
        print("x1 = x2 = ", x1)
    } else {
        x1 = (-b + sqrt(discriminant)) / (2 * a)
        x2 = (-b - sqrt(discriminant)) / (2 * a)
        print("x1 = ", x1)
        print("x2 = ", x2)
    }
} else {
    print("Уравнение не является квадратным т.к. a = 0 \n")
}



// ЗАДАНИЕ 2
//
//
let aCathetus = Double(3)
let bCathetus = Double(4)

var perimeter, area, hypotenuse: Double

hypotenuse = sqrt(aCathetus*aCathetus + bCathetus*bCathetus)
area = 0.5 * aCathetus * bCathetus
perimeter = aCathetus + bCathetus + hypotenuse

print("\n\n2. Площадь = \(area), периметр = \(perimeter) и гипотенузу = \(hypotenuse)")




// ЗАДАНИЕ 3
//
//
var contribution: Double = 100000
var percent: Double = 10
let duration = 5;

percent /= 100

if contribution > 0 && percent >= 0 && duration > 0 {
    for _ in 1...duration {
        contribution += contribution * percent
    }
    print("\n\n3. Сумма вклада через 5 лет = ", contribution)
} else {
    print("Неверные входные данные")
}
