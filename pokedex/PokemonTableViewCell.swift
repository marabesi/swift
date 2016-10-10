//
//  PokemonTableViewCell.swift
//  pokedex
//
//  Created by Jean Aparecido Chaves da Rocha on 27/08/16.
//  Copyright © 2016 FIAP. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var pokeImage: UIImageView!
    @IBOutlet var pokeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
