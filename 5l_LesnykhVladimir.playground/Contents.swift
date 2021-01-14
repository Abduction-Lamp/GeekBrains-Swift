//
//  Домашнее задание №5
//  Лесных Владимир
//
//

import Foundation

// MARK: Перечисления
//
enum Color: String {
    case White  = "Белый"
    case Black  = "Черный"
    case Red    = "Красный"
    case Blue   = "Синий"
    case Green  = "Зеленый"
    case Yellow = "Жёлный"
}

enum Transmission {
    case Manual
    case Automtic(type: AutomaticGearbox)

    enum AutomaticGearbox: String {
        case Automatic  = "Автоматическая"
        case Robot      = "Роботизированная"
        case Variator   = "Вариатор"
    }

    func print() -> String {
        var typeTransmission = ""
        switch self {
        case .Manual:
            typeTransmission = "Механника"
        case .Automtic(let typeAutomtic):
            typeTransmission = typeAutomtic.rawValue
        }
        return typeTransmission
    }
}

enum Trailer {
    case Yes(volume: UInt)
    case No

    func print() -> String {
        var trailer = ""
        switch self {
        case .No:
            trailer = "Нет"
        case .Yes(let volume):
            trailer = "Есть, объемом \(volume)"
        }
        return trailer
    }
}

enum OnOff: String {
    case On     = "Включен"
    case Off    = "Выключен"
}

enum OpenClosed: String {
    case Open   = "Открыты"
    case Closed = "Закрыты"
}

enum Actions {
    case ReplaceCarRims(diameter: UInt, color: Color)

    case AddTrailer(volume: UInt)
    case RemoveTrailer
    
    case LoadTrunk(volume: UInt)
    case UnloadTrunk(volume: UInt)
}


// MARK: Протокол Car
//
protocol Car {
    
    var brand: String { get }
    var model: String { get }
    var year: UInt { get }
    var color: Color { get }
    
    var transmission: Transmission { get }
    var engineVolume: UInt { get }

    var engineStatus: OnOff { get set }
    var doorsStatus: OpenClosed { get set }
    var windowStatus: OpenClosed { get set }
    var headlightsStatus: OnOff { get set }

    mutating func action(type: Actions) -> (successfully: Bool, message: String)
}


// MARK: Расширения протокола Car
//
extension Car {
    mutating func turnOffEngine() -> (successfully: Bool, message: String) {
        engineStatus = .Off
        return (successfully: true, message: brand + ": Двигатель заглушён")
    }
    mutating func turnOnEngine() -> (successfully: Bool, message: String)  {
        engineStatus = .On
        return (successfully: true, message: brand + ": Двигатель заведен")
    }
}

extension Car {
    mutating func openDoor() -> (successfully: Bool, message: String)  {
        doorsStatus = .Open
        return (successfully: true, message: brand + ": Двери открыты")
    }
    mutating func closedDoor() -> (successfully: Bool, message: String)  {
        doorsStatus = .Closed
        return (successfully: true, message: brand + ": Двери закрыты")
    }
}

extension Car {
    mutating func openWindow() -> (successfully: Bool, message: String)  {
        windowStatus = .Open
        return (successfully: true, message: brand + ": Окна открыты")
    }
    mutating func closedWindow() -> (successfully: Bool, message: String)  {
        windowStatus = .Closed
        return (successfully: true, message: brand + ": Окна закрыты")
    }
}

extension Car {
    mutating func turnOffHeadlights() -> (successfully: Bool, message: String)  {
        headlightsStatus = .Off
        return (successfully: true, message: brand + ": Фары выключены")
    }
    mutating func turnOnHeadlights() -> (successfully: Bool, message: String)  {
        headlightsStatus = .On
        return (successfully: true, message: brand + ": Фары включены")
    }
}



// MARK: Класс SportCar имплементирует протокол Car и протокол CustomStringConvertible
//
class SportCar : Car, CustomStringConvertible {
  
    var brand: String {
        didSet {
            brand = brand.prefix(1).uppercased() + brand.lowercased().dropFirst()
        }
    }
    var model: String

    var year: UInt
    var color: Color

    var transmission: Transmission
    var engineVolume: UInt

    var engineStatus: OnOff
    var doorsStatus: OpenClosed
    var windowStatus: OpenClosed
    var headlightsStatus: OnOff

    func action(type: Actions) -> (successfully: Bool, message: String) {

        var flag = true
        var message = ""
        
        switch type {
        case .ReplaceCarRims(let diameter, let color):
            message = "Заменены диски с \(rims.diameter) дюймов \(rims.color.rawValue.lowercased()) цвет, на диски \(diameter) дюймов \(color.rawValue.lowercased()) цвет"
            rims = (diameter: diameter, color: color)
        default:
            flag = false
            message = "Это действие недоступно для данного автомобиля"
        }

        return (successfully: flag, message: ("\(brand): " + message))
    }


    let speedMax: UInt
    let overclockingTo100: Float
    var rims: (diameter: UInt, color: Color)


    init(brand: String, model: String, year: UInt, color: Color, transmission: Transmission, engineVolume: UInt, speedMax: UInt, overclockingTo100: Float, rims: (diameter: UInt, color: Color)) {

        self.brand = brand.prefix(1).uppercased() + brand.lowercased().dropFirst()
        self.model = model
        self.year = year
        self.color = color
        self.transmission = transmission
        self.engineVolume = engineVolume
        self.speedMax = speedMax
        self.overclockingTo100 = overclockingTo100
        self.rims = rims
        
        engineStatus = .Off
        doorsStatus = .Closed
        windowStatus = .Closed
        headlightsStatus = .Off
    }
    
    
    var description: String {
        let output =
            """
            ----------------------------------------
            Автомобиль:\t\t\t\(brand)
            Модель:\t\t\t\t\(model)
            Год выпуска:\t\t\(year)
            Цвет:\t\t\t\t\(color.rawValue)
            Трансмиссия:\t\t\(transmission.print())
            Объем двигателя:\t\(engineVolume) см^3
            Диски:\t\t\t\t\(rims.diameter)" \(rims.color.rawValue) цвет

            Двигатель - \(engineStatus.rawValue)
            Двери - \(doorsStatus.rawValue)
            Окна - \(windowStatus.rawValue)
            Фары - \(headlightsStatus.rawValue)
            ----------------------------------------

            """
        return output
    }
}


// MARK: Класс TrunkCar имплементирует протокол Car и протокол CustomStringConvertible
//
class TrunkCar : Car, CustomStringConvertible {
    
    var brand: String {
        didSet {
            brand = brand.prefix(1).uppercased() + brand.lowercased().dropFirst()
        }
    }
    var model: String

    var year: UInt
    var color: Color

    var transmission: Transmission
    var engineVolume: UInt

    var engineStatus: OnOff
    var doorsStatus: OpenClosed
    var windowStatus: OpenClosed
    var headlightsStatus: OnOff
    
    
    func action(type: Actions) -> (successfully: Bool, message: String) {
        
        var flag = true
        var message = ""
        
        switch type {
        case .LoadTrunk(_) where currentVolumeTrunk == totalVolumeTrunk:
            flag = false
            message = "Кузов переполнен"
        case .LoadTrunk(let volume) where (currentVolumeTrunk + volume) <= totalVolumeTrunk:
            currentVolumeTrunk += volume
            message = "Кузов пополнился грузом объемом \(volume) л"
        case .LoadTrunk(let volume) where (currentVolumeTrunk + volume) > totalVolumeTrunk:
            message = "В кузов поместилось только \(totalVolumeTrunk - currentVolumeTrunk) л"
            currentVolumeTrunk = totalVolumeTrunk

        case .UnloadTrunk(_) where currentVolumeTrunk == 0:
            flag = false
            message = "Кузов пуст"
        case .UnloadTrunk(let volume) where volume >= currentVolumeTrunk:
            message = "Из кузова выгрузили весь груз в объеме \(currentVolumeTrunk) л"
            currentVolumeTrunk = 0
        case .UnloadTrunk(let volume) where volume < currentVolumeTrunk:
            message = "Из кузова выгрузили груз в объеме \(volume) л"
            currentVolumeTrunk -= volume

        case .AddTrailer(let volume):
            switch trailer {
            case .No:
                message = "К грузовику добавили прицеп объемом в \(volume) л"
                totalVolumeTrunk += volume
                trailer = .Yes(volume: volume)
            case .Yes(_):
                flag = false
                message = "Прицеп уже прицеплин"
            }
        case .RemoveTrailer:
            switch trailer {
            case .No:
                flag = false
                message = "Прицеп и так нет"
            case .Yes(let volume):
                message = "Прицеп был отцеплин"
                totalVolumeTrunk -= volume
                if currentVolumeTrunk > totalVolumeTrunk {
                    currentVolumeTrunk = totalVolumeTrunk
                }
                trailer = .No
            }
        
        default:
            flag = false
            message = "Это действие недоступно для данного автомобиля"
        }

        return (successfully: flag, message: ("\(brand): " + message))
    }
    
    
    var weight: UInt
    var trailer: Trailer
    
    var totalVolumeTrunk: UInt
    var currentVolumeTrunk: UInt
    var occupancyRate: String {
        get {
            var output = ""
            if totalVolumeTrunk == 0 {
                output = "0"
            } else {
                output = String(round((Double(currentVolumeTrunk)/Double(totalVolumeTrunk) * 100)))
            }
            return output
        }
    }
    
    
    init(brand: String, model: String, year: UInt, color: Color, transmission: Transmission, engineVolume: UInt, weight: UInt, totalVolumeTrunk: UInt) {

        self.brand = brand.prefix(1).uppercased() + brand.lowercased().dropFirst()
        self.model = model
        self.year = year
        self.color = color
        self.transmission = transmission
        self.engineVolume = engineVolume
        self.weight = weight
        self.totalVolumeTrunk = totalVolumeTrunk
        
        trailer = .No
        currentVolumeTrunk = 0
        
        engineStatus = .Off
        doorsStatus = .Closed
        windowStatus = .Closed
        headlightsStatus = .Off
    }
    
    
    var description: String {
        let output =
            """
            ----------------------------------------
            Автомобиль:\t\t\t\(brand)
            Модель:\t\t\t\t\(model)
            Год выпуска:\t\t\(year)
            Цвет:\t\t\t\t\(color.rawValue)
            Трансмиссия:\t\t\(transmission.print())
            Объем двигателя:\t\(engineVolume) см^3
            Грузоподъемность:\t\(weight) кг
            Наличие прицепа:\t\(trailer.print())
            Общий объем кузова:\t\(totalVolumeTrunk) литров; заполнен на \(occupancyRate)%

            Двигатель - \(engineStatus.rawValue)
            Двери - \(doorsStatus.rawValue)
            Окна - \(windowStatus.rawValue)
            Фары - \(headlightsStatus.rawValue)
            ----------------------------------------

            """
        return output
    }
}


// MARK: Инициализируем объекты
//
var porsche = SportCar(
    brand: "porsChe",
    model: "911 turbo S",
    year: 2020,
    color: .Blue,
    transmission: .Automtic(type: .Robot),
    engineVolume: 3745,
    speedMax: 320,
    overclockingTo100: 2.8,
    rims: (diameter: 20, color: .Black)
)

var volvo = TrunkCar(
    brand: "volvo",
    model: "FM",
    year: 2019,
    color: .Yellow,
    transmission: .Automtic(type: .Variator),
    engineVolume: 8200,
    weight: 30000,
    totalVolumeTrunk: 70000
)

var astonMartin = SportCar(
    brand: "Aston Martin",
    model: "Vanquish S",
    year: 2007,
    color: .White,
    transmission: .Manual,
    engineVolume: 5932,
    speedMax: 321,
    overclockingTo100: 4.0,
    rims: (diameter: 22, color: .Red)
 )


// MARK: Действия над объектами
//
var result: (successfully: Bool, message: String)

result = porsche.openDoor()
print(result.message)
result = porsche.openWindow()
print(result.message)
result = porsche.turnOnHeadlights()
print(result.message)
result = porsche.action(type: .AddTrailer(volume: 444))
print(result.message)
result = porsche.action(type: .ReplaceCarRims(diameter: 21, color: .Blue))
print(result.message)

result = volvo.action(type: .AddTrailer(volume: 100000))
print(result.message)
result = volvo.action(type: .LoadTrunk(volume: 5000000))
print(result.message)
result = volvo.action(type: .ReplaceCarRims(diameter: 21, color: .Blue))
print(result.message)
result = volvo.action(type: .UnloadTrunk(volume: 35000))
print(result.message)
result = volvo.turnOnEngine()
print(result.message)

result = astonMartin.turnOnHeadlights()
print(result.message)


// MARK: Полиморфизм
//
let carsArray: [CustomStringConvertible] = [porsche, volvo, astonMartin]
for car in carsArray {
    print(car)
}
