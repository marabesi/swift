protocol Car {
    var color: String { get set }
    var year: Int { get set }
    
    mutating func getCarInfo() -> String
}

class Honda: Car {
    
    var color: String = "red"
    var year: Int = 2016
    
    func getCarInfo() -> String {
        return "Car: \(color) - \(year)"
    }
}

var honda = Honda()

protocol Carro {
    var cor: String { get set }
}

class Fiat: Carro {
    var cor: String = ""
}

var palio = Fiat()
palio.cor = "preto"

struct Uno: Carro {
    var cor = "azul"
}