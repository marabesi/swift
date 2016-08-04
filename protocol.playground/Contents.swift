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