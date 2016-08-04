enum Month: Int {
    case January, February
    
    func getDaysNumber() -> Int {
        switch self {
        case .January:
            return 31
        default:
            return 30
        }
    }
}
