//
//  PokemonDetailViewController.swift
//  pokedex
//
//  Created by Matheus Marabesi on 8/27/16.
//  Copyright © 2016 FIAP. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, UITableViewDelegate {

    var pokemon = Pokemon()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var maxCp: UILabel!
    @IBOutlet weak var candiesToEvolve: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    @IBOutlet weak var attacksTable: UITableView!
    
    var attacks = [Attacks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        maxCp.text = pokemon.maxCp
        candiesToEvolve.text = pokemon.candiesToEvolve
        pokemonId.text = "#" + String(pokemon.id)
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        dispatch_async(backgroundQueue, {
            let imgData = NSData(contentsOfURL: self.pokemon.urlImage)
            let img = UIImage(data: imgData!)
        
            self.pokemonImage.image = img
        })
        
        let at1 = Attacks()
        at1.name = "voadora mata 1"
        at1.damage = 200
        
        attacks.append(at1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return attacks.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! AttackTableViewCell
        
        cell.name.text = attacks[indexPath.row].name
        cell.damage.text = String(attacks[indexPath.row].damage)
        
        return cell
    }
    
}
