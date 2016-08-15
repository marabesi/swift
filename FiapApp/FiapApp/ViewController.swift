//
//  ViewController.swift
//  FiapApp
//
//  Created by Matheus Marabesi on 8/13/16.
//  Copyright © 2016 Matheus Marabesi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokemonName: UITextField!
    
    var collection = [Pokemons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCreateNewPokemon(sender: AnyObject) {
        let alert = UIAlertController()
        alert.title = "Alert"
        alert.message = "Pokemon added!"
        alert.addAction(UIAlertAction(title: "Great", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }

    

}


/*
 if let ajshdjashd?{
 
 }
 
 */
