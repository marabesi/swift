//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Matheus Marabesi on 8/27/16.
//  Copyright © 2016 FIAP. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon = Pokemon()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            let imgData = NSData(contentsOfURL: self.pokemon.urlImage)
            let img = UIImage(data: imgData!)
        
            self.pokemonImage.image = img
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
