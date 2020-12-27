//  main.swift
//  Лесных Владимир
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
}

enum StatusEngine: String {
    case On     = "Включен"
    case Off    = "Выключен"
}

enum StatusDoorAndWindow: String {
    case Open   = "Открыты"
    case Closed = "Закрыты"
}

enum Trailer {
    case Yes(volume: UInt)
    case No
}

enum Actions {
    case OpenDoor
    case ClosedDoor
    
    case OpenWindow
    case ClosedWindow
    
    case OnEngine
    case OffEngine
    
    case LoadTrunk(volume: UInt)
    case UnloadTrunk(volume: UInt)
    
    case AddTrailer(volume: UInt)
    case RemoveTrailer
}


// MARK: Структуры
//
struct SportCar {
    
    var brand: String = ""
    var model: String = ""
    
    var year: UInt = 0
    var color: Color = .White
    var transmission: Transmission = .Manual
    
    var engineVolume: UInt = 0
    var speedMax: UInt = 0
    var overclockingTo100: Float = 0.0
    var fullTrunkVolume: UInt = 0
    var currentTrunkVolume: UInt = 0
    
    var engineStatus: StatusEngine = .Off
    var doorsStatus: StatusDoorAndWindow = .Closed
    var windowStatus: StatusDoorAndWindow = .Closed
    
    
    // MARK: Методы SportCar
    //
    func printInfo() -> Void {
        var typeTransmission = ""
        switch transmission {
        case .Manual:
            typeTransmission = "Механника"
        case .Automtic(let typeAutomtic):
            typeTransmission = typeAutomtic.rawValue
        }
        
        var percentageOfOccupancy = ""
        if fullTrunkVolume == 0 {
            percentageOfOccupancy = "0"
        } else {
            percentageOfOccupancy = String((Double(currentTrunkVolume)/Double(fullTrunkVolume)) * 100)
        }
        
        let str = """
        ------------------------------
        Автомобиль:\t\t\(brand)
        Модель:\t\t\t\(model)
        Год выпуска:\t\(year)
        Цвет:\t\t\t\(color.rawValue)
        Трансмиссия:\t\(typeTransmission)
        Объем двигателя:\t\t\(engineVolume) см^3
        Максимальная скорасть:\t\(speedMax) км/ч
        Разгон до 100 км/ч:\t\t\(overclockingTo100) с
        Объем багажника:\t\t\(fullTrunkVolume) литров \t заполнен на \(percentageOfOccupancy)%

        Двигатель - \(engineStatus.rawValue)
        Двери - \(doorsStatus.rawValue)
        Окна - \(windowStatus.rawValue)
        ------------------------------
        """
        print(str)
    }
    
    mutating func action(type: Actions) -> (successfully: Bool, message: String) {
        var flag = true
        var message = ""
        
        switch type {
        case .OpenDoor:
            if doorsStatus == .Open {
                message = "Двери и так открыты"
                flag = false
            } else {
                self.doorsStatus = .Open
                message = "Двери теперь открыты"
            }
        case .ClosedDoor:
            if doorsStatus == .Closed {
                message = "Двери и так закрыты"
                flag = false
            } else {
                self.doorsStatus = .Closed
                message = "Двери теперь закрыты"
            }
        case .OpenWindow:
            if windowStatus == .Open {
                message = "Окна и так открыты"
                flag = false
            } else {
                self.windowStatus = .Open
                message = "Окна теперь открыты"
            }
        case .ClosedWindow:
            if windowStatus == .Closed {
                message = "Окна и так закрыты"
                flag = false
            } else {
                self.windowStatus = .Closed
                message = "Окна теперь закрыты"
            }
        case .OnEngine:
            if engineStatus == .On {
                message = "Двигатель и так заведен"
                flag = false
            } else {
                self.engineStatus = .On
                message = "Двигатель теперь заведен"
            }
        case .OffEngine:
            if engineStatus == .Off {
                message = "Двигатель и так выключен"
                flag = false
            } else {
                self.engineStatus = .Off
                message = "Двигатель теперь выключен"
            }
        case .LoadTrunk(_) where currentTrunkVolume == fullTrunkVolume:
            message = "Багажник переполнен"
            flag = false
        case .LoadTrunk(let volume) where (currentTrunkVolume + volume) <= fullTrunkVolume:
            self.currentTrunkVolume += volume
            message = "Багажник пополнился грузов объемом \(volume) л"
        case .LoadTrunk(let volume) where (currentTrunkVolume + volume) > fullTrunkVolume:
            message = "В богажник поместилось только \(fullTrunkVolume - currentTrunkVolume) л"
            currentTrunkVolume = fullTrunkVolume
        case .UnloadTrunk(_) where currentTrunkVolume == 0:
            message = "Багажник пуст"
            flag = false
        case .UnloadTrunk(let volume) where volume >= currentTrunkVolume:
            message = "Из багажника выгрузили весь груз в объеме \(currentTrunkVolume) л"
            currentTrunkVolume = 0
        case .UnloadTrunk(let volume) where volume < currentTrunkVolume:
            message = "Из багажника выгрузили груз в объеме \(volume) л"
            currentTrunkVolume -= volume
        default:
            flag = false
            message = "Извините, это не возможно выполнить"
        }
        
        return (successfully: flag, message: ("В \(brand) " + message))
    }
}

struct TrunkCar {
    
    var brand: String = ""
    var model: String = ""
    
    var year: UInt = 0
    var color: Color = .White
    
    var transmission: Transmission = .Manual
    var engineVolume: UInt = 0
    
    var trailer: Trailer = .No
    var fullTrunkVolume: UInt = 0
    var currentTrunkVolume: UInt = 0
    
    var engineStatus: StatusEngine = .Off
    var doorsStatus: StatusDoorAndWindow = .Closed
    var windowStatus: StatusDoorAndWindow = .Closed
    
    
    // MARK: Методы TrunkCar
    //
    func printInfo() -> Void {
        var typeTransmission = ""
        switch transmission {
        case .Manual:
            typeTransmission = "Механника"
        case .Automtic(let typeAutomtic):
            typeTransmission = typeAutomtic.rawValue
        }
        
        var percentageOfOccupancy = ""
        if fullTrunkVolume == 0 {
            percentageOfOccupancy = "0"
        } else {
            percentageOfOccupancy = String((Double(currentTrunkVolume)/Double(fullTrunkVolume)) * 100)
        }
        
        var availabilityTrailer = ""
        switch trailer {
        case .No:
            availabilityTrailer = "Без прицепа"
        case .Yes(let volume):
            availabilityTrailer = "Есть прицеп объемом \(volume) л"
        }
        
        let str = """
        ------------------------------
        Автомобиль:\t\t\(brand)
        Модель:\t\t\t\(model)
        Год выпуска:\t\(year)
        Цвет:\t\t\t\(color.rawValue)

        Трансмиссия:\t\t\(typeTransmission)
        Объем двигателя:\t\(engineVolume) см^3

        Наличие прицепа:\t\t\(availabilityTrailer)
        Общий объем багажника:\t\(fullTrunkVolume) литров \t заполнен на \(percentageOfOccupancy)%

        Двигатель - \(engineStatus.rawValue)
        Двери - \(doorsStatus.rawValue)
        Окна - \(windowStatus.rawValue)
        ------------------------------
        """
        print(str)
    }
    
    mutating func action(type: Actions) -> (successfully: Bool, message: String) {
        var flag = true
        var message = ""
        
        switch type {
        case .OpenDoor:
            if doorsStatus == .Open {
                message = "Двери и так открыты"
                flag = false
            } else {
                self.doorsStatus = .Open
                message = "Двери теперь открыты"
            }
        case .ClosedDoor:
            if doorsStatus == .Closed {
                message = "Двери и так закрыты"
                flag = false
            } else {
                self.doorsStatus = .Closed
                message = "Двери теперь закрыты"
            }
        case .OpenWindow:
            if windowStatus == .Open {
                message = "Окна и так открыты"
                flag = false
            } else {
                self.windowStatus = .Open
                message = "Окна теперь открыты"
            }
        case .ClosedWindow:
            if windowStatus == .Closed {
                message = "Окна и так закрыты"
                flag = false
            } else {
                self.windowStatus = .Closed
                message = "Окна теперь закрыты"
            }
        case .OnEngine:
            if engineStatus == .On {
                message = "Двигатель и так заведен"
                flag = false
            } else {
                self.engineStatus = .On
                message = "Двигатель теперь заведен"
            }
        case .OffEngine:
            if engineStatus == .Off {
                message = "Двигатель и так выключен"
                flag = false
            } else {
                self.engineStatus = .Off
                message = "Двигатель теперь выключен"
            }
        case .LoadTrunk(_) where currentTrunkVolume == fullTrunkVolume:
            message = "Багажник переполнен"
            flag = false
        case .LoadTrunk(let volume) where (currentTrunkVolume + volume) <= fullTrunkVolume:
            self.currentTrunkVolume += volume
            message = "Багажник пополнился грузов объемом \(volume) л"
        case .LoadTrunk(let volume) where (currentTrunkVolume + volume) > fullTrunkVolume:
            message = "В богажник поместилось только \(fullTrunkVolume - currentTrunkVolume) л"
            currentTrunkVolume = fullTrunkVolume
        case .UnloadTrunk(_) where currentTrunkVolume == 0:
            message = "Багажник пуст"
            flag = false
        case .UnloadTrunk(let volume) where volume >= currentTrunkVolume:
            message = "Из багажника выгрузили весь груз в объеме \(currentTrunkVolume) л"
            currentTrunkVolume = 0
        case .UnloadTrunk(let volume) where volume < currentTrunkVolume:
            message = "Из багажника выгрузили груз в объеме \(volume) л"
            currentTrunkVolume -= volume
        case .AddTrailer(let volume):
            switch trailer {
            case .No:
                message = "Прицепили уже прицеп объемом в \(volume) л"
                fullTrunkVolume += volume
                trailer = .Yes(volume: volume)
            case .Yes(_):
                message = "Прицеп уже прицеплин"
                flag = false
            }
        case .RemoveTrailer:
            switch trailer {
            case .No:
                message = "Прицеп и так нет"
                flag = false
            case .Yes(let volume):
                message = "Прицеп отцеплин"
                fullTrunkVolume -= volume
                if currentTrunkVolume > fullTrunkVolume {
                    currentTrunkVolume = fullTrunkVolume
                }
                trailer = .No
            }
        default:
            flag = false
            message = "Извините, это не возможно выполнить"
        }
        
        return (successfully: flag, message: ("В \(brand) " + message))
    }
}


// MARK: Экземпляры
//
var porsche = SportCar(
    brand: "Porsche",
    model: "911 turbo S",
    year: 2020,
    color: .Blue,
    transmission: .Automtic(type: .Automatic),
    engineVolume: 3745,
    speedMax: 320,
    overclockingTo100: 2.8,
    fullTrunkVolume: 264,
    currentTrunkVolume: 0,
    engineStatus: .Off,
    doorsStatus: .Closed
)
porsche.printInfo()

var astonMartin = SportCar(
    brand: "Aston Martin",
    model: "Vanquish S",
    year: 2007,
    color: .White,
    transmission: .Automtic(type: .Robot),
    engineVolume: 5932,
    speedMax: 321,
    overclockingTo100: 4.0,
    fullTrunkVolume: 240,
    currentTrunkVolume: 0,
    engineStatus: .Off,
    doorsStatus: .Closed
)
astonMartin.printInfo()

var volvo = TrunkCar(
    brand: "Volvo",
    model: "FM",
    year: 2021,
    color: .Yellow,
    transmission: .Automtic(type: .Variator),
    engineVolume: 8000,
    trailer: .Yes(volume: 3500),
    fullTrunkVolume: 7500,
    currentTrunkVolume: 0,
    engineStatus: .Off,
    doorsStatus: .Closed
)
volvo.printInfo()


// MARK: Меняем свойства
//
var result: (successfully: Bool, message: String)

result = porsche.action(type: .ClosedDoor)
print(result.message)
result = porsche.action(type: .OpenDoor)
print(result.message)
result = porsche.action(type: .OnEngine)
print(result.message)
result = porsche.action(type: .LoadTrunk(volume: 50))
print(result.message)
result = porsche.action(type: .UnloadTrunk(volume: 100))
print(result.message)
result = porsche.action(type: .LoadTrunk(volume: 100))
print(result.message)
result = porsche.action(type: .LoadTrunk(volume: 100))
print(result.message)
result = porsche.action(type: .LoadTrunk(volume: 100))
print(result.message)

result = astonMartin.action(type: .LoadTrunk(volume: 100))
print(result.message)
result = astonMartin.action(type: .UnloadTrunk(volume: 10))
print(result.message)
result = astonMartin.action(type: .OpenDoor)
print(result.message)

porsche.printInfo()
astonMartin.printInfo()


result = volvo.action(type: .LoadTrunk(volume: 100))
print(result.message)
result = volvo.action(type: .UnloadTrunk(volume: 10))
print(result.message)
result = volvo.action(type: .OpenDoor)
print(result.message)
result = volvo.action(type: .RemoveTrailer)
print(result.message)

volvo.printInfo()

result = volvo.action(type: .AddTrailer(volume: 5000))
print(result.message)
result = volvo.action(type: .LoadTrunk(volume: 10000))
print(result.message)
result = volvo.action(type: .OpenWindow)
print(result.message)

volvo.printInfo()
