enum MeuErro: ErrorType {
    case TipoErrado
}

func andar(tipo: String, metros: Int) throws {
    if (tipo == "passarinho") {
            throw MeuErro.TipoErrado
    }
    
    print("Andando \(metros) metros")
}

do {
    try
        
    andar("pessoa", metros: 10)
    
} catch MeuErro.TipoErrado {
    print("O tipo passado não pode andar")
}


do {
    try
        
        andar("passarinho", metros: 10)
    
} catch MeuErro.TipoErrado {
    print("O tipo passado não pode andar")
}
