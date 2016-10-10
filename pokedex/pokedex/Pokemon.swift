//
//  Pokemon.swift
//  pokedex
//
//  Created by Matheus Marabesi on 8/22/16.
//  Copyright © 2016 FIAP. All rights reserved.
//

import UIKit

class Pokemon: NSObject {

    var id = Int()  
    var image = UIImage(named:"")
    var name = String()
    var urlImage = URL(string:"www.teste.com")
    
    var maxCp = String()
    var candiesToEvolve = String()
}
