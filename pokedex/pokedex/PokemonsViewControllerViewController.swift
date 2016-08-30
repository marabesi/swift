//
//  PokemonsViewController.swift
//  pokedex
//
//  Created by Jean Aparecido Chaves da Rocha on 22/08/16.
//  Copyright © 2016 Jean Rocha. All rights reserved.
//

import UIKit

private let reuseIdentifier = "pokemonViewCell"

class PokemonsViewController: UIViewController, UICollectionViewDelegate, UISearchControllerDelegate, UITableViewDelegate {
    
    var collection = [Pokemon]()
    var selectedPoke = Pokemon()
    var filterCollection = NSArray()
    
    
    
    @IBOutlet var searchController: UISearchDisplayController!
    @IBOutlet weak var pokeCollection: UICollectionView!
    
    func loadData() {
        let urlPath: String = "https://raw.githubusercontent.com/marabesi/swift/master/pokedex-api/pokemons.json"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    let pokes = json["pokemons"] as? NSArray
                    
                    for pokemon in pokes! {
                        let items = pokemon as! NSDictionary
                        
                        let newPokemon = Pokemon()
                        
                        newPokemon.id = items.objectForKey("id")! as! Int
                        newPokemon.name = items.objectForKey("name")! as! String
                        newPokemon.urlImage = NSURL(string: items.objectForKey("img_url") as! String)!
                        newPokemon.maxCp = items.objectForKey("max_cp")! as! String
                        newPokemon.candiesToEvolve = items.objectForKey("candies_to_evolve")! as! String
                        
                        self.collection.append(newPokemon)
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.pokeCollection.reloadData()
                    }
                } else {
                    print("error")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        let nibName = UINib(nibName: "PokemonTableViewCell", bundle:nil)
        self.searchController.searchResultsTableView.registerNib(nibName, forCellReuseIdentifier: "PokeTableCell")
        self.searchController.searchResultsTableView.separatorStyle = .None
        self.searchController.searchResultsTableView.backgroundColor = UIColor (colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.8)
        self.searchController.searchResultsTableView.rowHeight = 70
        //        searchController.searchBar.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedPoke = filterCollection[indexPath.row] as! Pokemon
        self.performSegueWithIdentifier("pokemon_detail_segue", sender: nil)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return collection.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PokemonCollectionViewCell
        
        cell.name.text = collection[indexPath.row].name
        
        //        let imgData = NSData(contentsOfURL: collection[indexPath.row].urlImage)
        //        cell.pokeImage.image = UIImage(data: imgData!)
        
        cell.pokeImage.image = nil

        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            //            print("This is run on the background queue")
            
            let imgData = NSData(contentsOfURL: self.collection[indexPath.row].urlImage)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //                print("This is run on the main queue, after the previous code in outer block")
                self.collection[indexPath.row].image = UIImage(data: imgData!)!
                //                cell.pokeImage.image = UIImage(data: imgData!)
                cell.pokeImage.image = self.collection[indexPath.row].image
            })
        })
        
        return cell
    }
    
    
    
    // MARK: UISearchControllerDelegate
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (collection as NSArray).filteredArrayUsingPredicate(searchPredicate)
        filterCollection = array as! [NSArray]
        //        self.tblView.reloadData()
        self.searchController.searchResultsTableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.active {
            return self.filterCollection.count
        }
        
        return 1;
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = searchController.searchResultsTableView.dequeueReusableCellWithIdentifier("PokeTableCell", forIndexPath: indexPath) as! PokemonTableViewCell
        
        
        if self.searchController.active {
            
            let pokemon = filterCollection[indexPath.row] as! Pokemon
            
            cell.pokeName.text = pokemon.name
        
            
            if pokemon.image != nil {
                cell.pokeImage.image = pokemon.image
            }
            else{
                
                let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
                dispatch_async(backgroundQueue, {
                    //            print("This is run on the background queue")
                    
                    let imgData = NSData(contentsOfURL: self.collection[indexPath.row].urlImage)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        cell.pokeImage.image = UIImage(data: imgData!)
                    })
                })
                
            }
        }
        
        
        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }
    
    func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedPoke = collection[indexPath.row]
        
        self.performSegueWithIdentifier("pokemon_detail_segue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toVc:PokemonDetailViewController = segue.destinationViewController as! PokemonDetailViewController
        toVc.pokemon = selectedPoke
    }
}
