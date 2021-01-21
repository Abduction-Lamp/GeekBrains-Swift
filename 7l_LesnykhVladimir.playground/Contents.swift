//
//  Домашнее задание №7
//  Лесных Владимир
//
//

import Foundation

//  MARK:   Часть 1
//          Есть переменная network, которая содержит все подключенные устройства в сети (принтеры)
//          Есть класс NetworkPrinter, описывает устройство и имеет метод goPrint - распечатывает документ
//          Функция connect пытаеться подключиться к указанному IP и послать документ на мечать
//
//          Ошибки могут быть:  1) Устройство с таким IP не существует
//                              2) Притнер занят
//                              3) Латок с бумагой пуст
//                              4) Картридж закончился
//

enum ErrorsNetworkPrinter : String, Error {
    case NotDetectedOnNetwork = "Данное устройство не обнаружено в сети"
    case NoPaper = "Латок с бумагой пуст"
    case NoPaint = "Картридж закончился"
    case Busy = "Принтер занят"
}


class NetworkPrinter : CustomStringConvertible {

    enum Status {
        case Busy
        case Free
    }

    let model: String
    var paperInPrinter: Bool
    var paintInCartridge: UInt8
    var status: Status
    
    init(model: String, paperInPrinter: Bool, paintInCartridge: UInt8) {
        self.model = model
        self.paperInPrinter = paperInPrinter
        self.paintInCartridge = paintInCartridge
        status = .Free
    }
    
    var description: String {
        let str =   """
                    ----------------------------------------
                    Принтер: \(model)
                    Статус: \(status)


                    """
        return str
    }
    
    func goPrint(document: String) -> (successfully: Bool, error: ErrorsNetworkPrinter?) {
        
        guard status == .Free else {
            return (successfully: false, error: .Busy)
        }
        
        guard paperInPrinter == true else {
            return (successfully: false, error: .NoPaper)
        }
        
        guard paintInCartridge > 0 else {
            return (successfully: false, error: .NoPaint)
        }
        
        status = .Busy
        print(document)
        print(self.description)
        status = .Free
        
        return (successfully: true, error: nil)
    }
}



func connect(ip: String, network: inout [String : NetworkPrinter]) -> (successfully: Bool, error: ErrorsNetworkPrinter?) {
    
    guard let printer = network[ip] else {
        return (successfully: false, error: .NotDetectedOnNetwork)
    }
    
    return printer.goPrint(document: "Этис Атис Аниматис Этис Атис Аматис")
}


//  MARK:   Создаем словарь с устройствами в сети
//
var network = [String : NetworkPrinter]()

network["10.10.37.1"] = NetworkPrinter(
    model: "HP LaserJet1010",
    paperInPrinter: true,
    paintInCartridge: 100
)
network["10.10.37.2"] = NetworkPrinter(
    model: "HP LaserJet1011",
    paperInPrinter: false,
    paintInCartridge: 100
)
network["10.10.37.3"] = NetworkPrinter(
    model: "HP LaserJet1012",
    paperInPrinter: true,
    paintInCartridge: 0
)


//  MARK:   Пробуем подсоединиться и напечатать документ
//
print("ЧАСТЬ 1\n")
var result = connect(ip: "10.10.37.1", network: &network)
if result.successfully {
    print("Документ успешно напечатан\n")
} else {
    print(result.error!.rawValue)
}

result = connect(ip: "10.10.37.2", network: &network)
if result.successfully {
    print("Документ успешно напечатан\n")
} else {
    print(result.error!.rawValue)
}

result = connect(ip: "10.10.37.3", network: &network)
if result.successfully {
    print("Документ успешно напечатан\n")
} else {
    print(result.error!.rawValue)
}

result = connect(ip: "10.10.37.4", network: &network)
if result.successfully {
    print("Документ успешно напечатан\n")
} else {
    print(result.error!.rawValue)
}




//  MARK:   Часть 2
//          Есть банкомат, класс CashMachine, в нем хранятья деньги и БД с данными для идентификации
//          Есть класс Card, описывает данные карты, в том читсле кол-во денег на счету
//

enum ErrorsCashMachine : String, Error {
    case NonExistentAccount = "Такой счет несуществует"
    case InvalidPin = "Неверный pin-код"
    case NotEnoughMoneyInAccount = "Недостаточно денег на счету"
    case NotEnoughMoneyAtATM = "Недостаточно денег в банкомате"
    case NoСonnectionDB = "Нет соединение"
}

class Card {
    
    let account: Decimal
    private let pin: UInt
    private var money: Decimal
    
    init(account: Decimal, pin: UInt, money: Decimal) {
        self.account = account
        self.pin = pin
        self.money = money
    }
    
    func withdrawMoney(amount: Decimal, pin: UInt) throws -> Decimal {
        guard self.pin == pin else {
            throw ErrorsCashMachine.InvalidPin
        }
        guard money >= amount else {
            throw ErrorsCashMachine.NotEnoughMoneyInAccount
        }
        
        money -= amount
        return amount
    }
    
    func info() -> Decimal {
        return money
    }
}

class CashMachine {
    
    private var db = [Decimal : Card]()
    private var totalAmountOfCash: Decimal
    
    
    init() {
        totalAmountOfCash = 1_000_000_000
        
        db[4000_1111_2222_0001] = Card(
            account: 4000_1111_2222_0001,
            pin: 1234,
            money: 1_000_000
        )
        db[4000_1111_2222_0002] = Card(
            account: 4000_1111_2222_0002,
            pin: 4321,
            money: 1_000
        )
        db[4000_1111_2222_0003] = Card(
            account: 4000_1111_2222_0003,
            pin: 1122,
            money: 37_000_000_000
        )
    }
    
    
    private func connect(account: Decimal) throws -> Card {
        if db.isEmpty {
            throw ErrorsCashMachine.NoСonnectionDB
        }
        guard let card = db[account] else {
            throw ErrorsCashMachine.NonExistentAccount
        }
        
        return card
    }
    
    func getMoney(account: Decimal, amount: Decimal, pin: UInt) throws -> Decimal {
        var output = Decimal(0)
        do {
            let card = try connect(account: account)
            guard amount <= totalAmountOfCash else {
                print(ErrorsCashMachine.NotEnoughMoneyAtATM.rawValue + " Вы можите снять \(totalAmountOfCash)")
                throw ErrorsCashMachine.NotEnoughMoneyAtATM
            }
            output = try card.withdrawMoney(amount: amount, pin: pin)
            totalAmountOfCash -= output
        } catch ErrorsCashMachine.NoСonnectionDB {
            print(ErrorsCashMachine.NoСonnectionDB.rawValue)
        } catch ErrorsCashMachine.NonExistentAccount {
            print(ErrorsCashMachine.NonExistentAccount.rawValue)
        } catch ErrorsCashMachine.InvalidPin {
            print(ErrorsCashMachine.InvalidPin.rawValue)
        } catch ErrorsCashMachine.NotEnoughMoneyInAccount {
            print(ErrorsCashMachine.NotEnoughMoneyInAccount.rawValue)
        }
        return output
    }
}



//  MARK:   Создаем банкомат и пробуем снять с него денег
//
print("\n\n\nЧАСТЬ 2\n")

let sber = CashMachine()

var money = try? sber.getMoney(
    account: 4000_1111_2222_0001,
    amount: 1_000_000,
    pin: 1234
)
print("Выданно:")
print(money ?? "nil")
print("")


money = try? sber.getMoney(
    account: 4000_1111_2222_0002,
    amount: 1_000_000,
    pin: 4321
)
print("Выданно:")
print(money ?? "nil")
print("")

money = try? sber.getMoney(
    account: 4000_1111_2222_0002,
    amount: 1_000_000,
    pin: 432
)
print("Выданно:")
print(money ?? "nil")
print("")

money = try? sber.getMoney(
    account: 4000_1111_2222_0000,
    amount: 1_000_000,
    pin: 4321
)
print("Выданно:")
print(money ?? "nil")
print("")


money = try? sber.getMoney(
    account: 4000_1111_2222_0003,
    amount: 1_000_000_000,
    pin: 1122
)
print("Выданно:")
print(money ?? "nil")
print("")
