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
