//
//  TableViewController.swift
//  FiapApp
//
//  Created by Matheus Marabesi on 8/13/16.
//  Copyright © 2016 Matheus Marabesi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var pokemons = [Pokemons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = Pokemons()
        p1.name = "pikachu"
        p1.image = UIImage(named: "pokemon1")
        
        let p2 = Pokemons()
        p2.name = "bubassauro"
        p2.image = UIImage(named: "pokemon2")
        
        let p3 = Pokemons()
        p3.name = "charmander"
        p3.image = UIImage(named: "pokemon3")
        
        let p4 = Pokemons()
        p4.name = "vulpix"
        p4.image = UIImage(named: "pokemon4")
        
        let p5 = Pokemons()
        p5.name = "abra"
        p5.image = UIImage(named: "pokemon5")
        
        pokemons.append(p1)
        pokemons.append(p2)
        pokemons.append(p3)
        pokemons.append(p4)
        pokemons.append(p5)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!TableViewCell

        cell.imageView?.image = pokemons[indexPath.row].image
        cell.textLabel?.text = pokemons[indexPath.row].name
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected = pokemons[indexPath.row]
        
        self.performSegueWithIdentifier("detail_segue", sender: selected )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let svc = segue.destinationViewController as! DetailViewController;
        
        let poke = sender as! Pokemons
        
        svc.textFromTable = poke.name
        svc.imageFromTable = poke.image
    }
}
