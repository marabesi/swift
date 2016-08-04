class Poligon {
    
    var sides:Int;
    
    init(sides:Int) {
        self.sides = sides
    }
    
    func getDescription() -> String
    {
        return "\(self.sides) sides"
    }
}
