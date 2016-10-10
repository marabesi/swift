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
        
        var imgListArray :[UIImage] = []
        for countValue in 0...29
        {
            imgListArray.append(UIImage(named: "PokebolaAnimacao_\(countValue).png")!)
        }
        
        self.pokemonImage.animationImages = imgListArray;
        self.pokemonImage.animationDuration = 0.9
        self.pokemonImage.startAnimating()
        
        nameLabel.text = pokemon.name
        maxCp.text = pokemon.maxCp
        candiesToEvolve.text = pokemon.candiesToEvolve
        pokemonId.text = "#" + String(pokemon.id)
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
        backgroundQueue.async(execute: {
            let imgData = try? Data(contentsOf: self.pokemon.urlImage! as URL)
            let img = UIImage(data: imgData!)
            self.pokemonImage.stopAnimating()
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
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return attacks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AttackTableViewCell
        
        cell.name.text = attacks[(indexPath as NSIndexPath).row].name
        cell.damage.text = String(attacks[(indexPath as NSIndexPath).row].damage)
        
        return cell
    }
    
}
