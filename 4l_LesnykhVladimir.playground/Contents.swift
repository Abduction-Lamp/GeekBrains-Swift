//
//  Домашнее задание №4
//
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

enum StatusEngine: String {
     case On     = "Включен"
     case Off    = "Выключен"
 }

enum StatusDoorAndWindow: String {
     case Open   = "Открыты"
     case Closed = "Закрыты"
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


// MARK: Класс Car
//
class Car {
    
    static var count: UInt = 0
    
    var brand: String {
        didSet {
            brand = brand.prefix(1).uppercased() + brand.lowercased().dropFirst()
        }
    }
    let model: String
    
    let year: UInt
    let color: Color
    
    let transmission: Transmission
    let engineVolume: UInt
    
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
    
    var engineStatus: StatusEngine
    var doorsStatus: StatusDoorAndWindow
    var windowStatus: StatusDoorAndWindow
    
    
    init(brand: String, model: String, year: UInt, color: Color, transmission: Transmission, engineVolume: UInt, trunkVolume: UInt) {
        
        self.brand = brand.prefix(1).uppercased() + brand.lowercased().dropFirst()
        self.model = model
        self.year = year
        self.color = color
        self.transmission = transmission
        self.engineVolume = engineVolume
        
        totalVolumeTrunk = trunkVolume
        currentVolumeTrunk = 0
        
        engineStatus = .Off
        doorsStatus = .Closed
        windowStatus = .Closed
        
        Car.count += 1
    }
    
    deinit {
        Car.count -= 1
        print("Car count = \(Car.count): Deleted an instance (\(brand)) of the Car class")
    }
    
    
    func action(type: Actions) -> (successfully: Bool, message: String) {
        
        var flag = true
        var message = ""

        switch type {
        case .OpenDoor:
            if doorsStatus == .Open {
                flag = false
                message = "Двери и так открыты"
            } else {
                self.doorsStatus = .Open
                message = "Двери теперь открыты"
            }
        case .ClosedDoor:
            if doorsStatus == .Closed {
                flag = false
                message = "Двери и так закрыты"
            } else {
                self.doorsStatus = .Closed
                message = "Двери теперь закрыты"
            }
        case .OpenWindow:
            if windowStatus == .Open {
                flag = false
                message = "Окна и так открыты"
            } else {
                self.windowStatus = .Open
                message = "Окна теперь открыты"
            }
        case .ClosedWindow:
            if windowStatus == .Closed {
                flag = false
                message = "Окна и так закрыты"
            } else {
                self.windowStatus = .Closed
                message = "Окна теперь закрыты"
            }
        case .OnEngine:
            if engineStatus == .On {
                flag = false
                message = "Двигатель и так заведен"
            } else {
                self.engineStatus = .On
                message = "Двигатель теперь заведен"
            }
        case .OffEngine:
            if engineStatus == .Off {
                flag = false
                message = "Двигатель и так выключен"
            } else {
                self.engineStatus = .Off
                message = "Двигатель теперь выключен"
            }
        default:
            flag = false
            message = "Извините, это действие не возможно выполнить"
        }

        return (successfully: flag, message: ("\(brand): " + message))
    }
    
    
    func printDescription() -> Void {
        
        let str = """
        ------------------------------
        Автомобиль:\t\t\t\(brand)
        Модель:\t\t\t\t\(model)
        Год выпуска:\t\t\(year)
        Цвет:\t\t\t\t\(color.rawValue)
        Трансмиссия:\t\t\(transmission.print())
        Объем двигателя:\t\(engineVolume) см^3
        Объем багажника:\t\(totalVolumeTrunk) литров; заполнен на \(occupancyRate)%

        Двигатель - \(engineStatus.rawValue)
        Двери - \(doorsStatus.rawValue)
        Окна - \(windowStatus.rawValue)
        ------------------------------
        """
        print(str)
    }
}


// MARK: Класс SportCar
//
class SportCar : Car {
    
    let speedMax: UInt
    let overclockingTo100: Float
    
    
    init(brand: String, model: String, year: UInt, color: Color, transmission: Transmission, engineVolume: UInt, trunkVolume: UInt, speedMax: UInt, overclockingTo100: Float) {
        
        self.speedMax = speedMax
        self.overclockingTo100 = overclockingTo100
        super.init(
            brand: brand,
            model: model,
            year: year,
            color: color,
            transmission: transmission,
            engineVolume: engineVolume,
            trunkVolume: trunkVolume
        )
    }
    
    deinit {
        print("Car count = \(Car.count): Deleted an instance (\(brand)) of the SportCar class")
    }
    
    
    override func action(type: Actions) -> (successfully: Bool, message: String) {
        
        var flag = true
        var message = ""

        switch type {
        
        case .LoadTrunk(_) where currentVolumeTrunk == totalVolumeTrunk:
            flag = false
            message = "Багажник переполнен"
        case .LoadTrunk(let volume) where (currentVolumeTrunk + volume) <= totalVolumeTrunk:
            currentVolumeTrunk += volume
            message = "Багажник пополнился грузом объемом \(volume) л"
        case .LoadTrunk(let volume) where (currentVolumeTrunk + volume) > totalVolumeTrunk:
            message = "В богажник поместилось только \(totalVolumeTrunk - currentVolumeTrunk) л"
            currentVolumeTrunk = totalVolumeTrunk
            
        case .UnloadTrunk(_) where currentVolumeTrunk == 0:
            flag = false
            message = "Багажник пуст"
        case .UnloadTrunk(let volume) where volume >= currentVolumeTrunk:
            message = "Из багажника выгрузили весь груз в объеме \(currentVolumeTrunk) л"
            currentVolumeTrunk = 0
        case .UnloadTrunk(let volume) where volume < currentVolumeTrunk:
            message = "Из багажника выгрузили груз в объеме \(volume) л"
            currentVolumeTrunk -= volume
            
        default:
            let result = super.action(type: type)
            return result
        }
        return (successfully: flag, message: ("\(brand): " + message))
    }
    
    
    override func printDescription() -> Void {
        
        let str = """
        ------------------------------
        Автомобиль:\t\t\t\(brand)
        Модель:\t\t\t\t\(model)
        Год выпуска:\t\t\(year)
        Цвет:\t\t\t\t\(color.rawValue)
        Трансмиссия:\t\t\(transmission.print())
        Макс. скорасть:\t\t\(speedMax) км/ч
        Разгон до сотни:\t\(overclockingTo100) с
        Объем двигателя:\t\(engineVolume) см^3
        Объем багажника:\t\(totalVolumeTrunk) литров; заполнен на \(occupancyRate)%

        Двигатель - \(engineStatus.rawValue)
        Двери - \(doorsStatus.rawValue)
        Окна - \(windowStatus.rawValue)
        ------------------------------

        """
        print(str)
    }
}


// MARK: Класс TrunkCar
//
class TrunkCar : Car {

    let weight: UInt
    var trailer: Trailer


    init(brand: String, model: String, year: UInt, color: Color, transmission: Transmission, engineVolume: UInt, weight: UInt, trunkVolume: UInt) {

        self.weight = weight
        self.trailer = .No

        super.init(
            brand: brand,
            model: model,
            year: year,
            color: color,
            transmission: transmission,
            engineVolume: engineVolume,
            trunkVolume: trunkVolume
        )
    }

    deinit {
        print("Car count = \(Car.count): Deleted an instance (\(brand)) of the TrunkCar class")
    }
    
    
    override func action(type: Actions) -> (successfully: Bool, message: String) {

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
            let result = super.action(type: type)
            return result
        }

        return (successfully: flag, message: ("\(brand): " + message))
    }

    
    override func printDescription() -> Void {
        let str = """
        ------------------------------
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
        ------------------------------

        """
        print(str)
    }
}


// MARK: Экземпляры
//
if true {
    let porsche = SportCar(
        brand: "porsChe",
        model: "911 turbo S",
        year: 2020,
        color: .Blue,
        transmission: .Automtic(type: .Robot),
        engineVolume: 3745,
        trunkVolume: 264,
        speedMax: 320,
        overclockingTo100: 2.8
    )
    
    let astonMartin = SportCar(
        brand: "Aston Martin",
        model: "Vanquish S",
        year: 2007,
        color: .White,
        transmission: .Manual,
        engineVolume: 5932,
        trunkVolume: 240,
        speedMax: 321,
        overclockingTo100: 4.0
     )

    let volvo = TrunkCar(
        brand: "volvo",
        model: "FM",
        year: 2019,
        color: .Yellow,
        transmission: .Automtic(type: .Variator),
        engineVolume: 8200,
        weight: 30000,
        trunkVolume: 70000
    )


    var result: (successfully: Bool, message: String)

    result = porsche.action(type: .ClosedDoor)
    print(result.message)
    result = porsche.action(type: .LoadTrunk(volume: 2000))
    print(result.message)
    result = porsche.action(type: .OpenWindow)
    print(result.message)
    result = porsche.action(type: .OnEngine)
    print(result.message)
    result = porsche.action(type: .UnloadTrunk(volume: 64))
    print(result.message)
    result = porsche.action(type: .AddTrailer(volume: 700))
    print(result.message)

    porsche.printDescription()

    result = astonMartin.action(type: .ClosedWindow)
    print(result.message)
    result = astonMartin.action(type: .LoadTrunk(volume: 1000))
    print(result.message)

    astonMartin.printDescription()
    
    result = volvo.action(type: .OpenDoor)
    print(result.message)
    result = volvo.action(type: .OpenWindow)
    print(result.message)
    result = volvo.action(type: .OnEngine)
    print(result.message)

    volvo.printDescription()

    result = volvo.action(type: .AddTrailer(volume: 100000))
    print(result.message)
    result = volvo.action(type: .LoadTrunk(volume: 100000))
    print(result.message)

    volvo.printDescription()

    result = volvo.action(type: .RemoveTrailer)
    print(result.message)
    result = volvo.action(type: .UnloadTrunk(volume: 35000))
    print(result.message)

    volvo.printDescription()
}
print("The End")
