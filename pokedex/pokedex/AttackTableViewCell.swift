//
//  AttackTableViewCell.swift
//  pokedex
//
//  Created by Matheus Marabesi on 8/27/16.
//  Copyright © 2016 FIAP. All rights reserved.
//

import UIKit

class AttackTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var damage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
