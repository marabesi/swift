struct House {
    var area: Float = 0
    var year: Int = 2016
    
    func getHouseInfo() -> String {
        return " House - \(year)"
    }
}

var house1 = House()
house1.area = 20

var house2 = house1

house2.area = 30

print(house1.area)
print(house2.area)

func troca<Generico>(inout a: Generico, inout b: Generico) {
    let temp = a
    a = b
    b = temp
}

//var a = 10, b = 20
var a = "um", b = "dois"

print("Valores : a = \(a) b = \(b)")

troca(&a, b: &b)


print("Valores : a = \(a) b = \(b)")



