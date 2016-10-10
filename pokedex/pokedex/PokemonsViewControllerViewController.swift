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
        let url: URL = URL(string: urlPath)!
        let request1: URLRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request1) {data, response, err in
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                    
                    let pokes = json["pokemons"] as? NSArray
                    
                    for pokemon in pokes! {
                        let items = pokemon as! NSDictionary
                        
                        let newPokemon = Pokemon()
                        
                        newPokemon.id = items.object(forKey: "id")! as! Int
                        newPokemon.name = items.object(forKey: "name")! as! String
                        newPokemon.urlImage = URL(string: items.object(forKey: "img_url") as! String)!
                        newPokemon.maxCp = items.object(forKey: "max_cp")! as! String
                        newPokemon.candiesToEvolve = items.object(forKey: "candies_to_evolve")! as! String
                        
                        self.collection.append(newPokemon)
                    }
                    
                    DispatchQueue.main.async {
                        self.pokeCollection.reloadData()
                    }
                } else {
                    print("error")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }

            
            
            print("Entered the completionHandler")
            }.resume()

        
//        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: URLResponse?, data: Data?, error: NSError?) -> Void in
//            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
//                    
//                    let pokes = json["pokemons"] as? NSArray
//                    
//                    for pokemon in pokes! {
//                        let items = pokemon as! NSDictionary
//                        
//                        let newPokemon = Pokemon()
//                        
//                        newPokemon.id = items.object(forKey: "id")! as! Int
//                        newPokemon.name = items.object(forKey: "name")! as! String
//                        newPokemon.urlImage = URL(string: items.object(forKey: "img_url") as! String)!
//                        newPokemon.maxCp = items.object(forKey: "max_cp")! as! String
//                        newPokemon.candiesToEvolve = items.object(forKey: "candies_to_evolve")! as! String
//                        
//                        self.collection.append(newPokemon)
//                    }
//                    
//                    DispatchQueue.main.async {
//                        self.pokeCollection.reloadData()
//                    }
//                } else {
//                    print("error")
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        } as! (URLResponse?, Data?, Error?) -> Void)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        let nibName = UINib(nibName: "PokemonTableViewCell", bundle:nil)
        self.searchController.searchResultsTableView.register(nibName, forCellReuseIdentifier: "PokeTableCell")
        self.searchController.searchResultsTableView.separatorStyle = .none
        self.searchController.searchResultsTableView.backgroundColor = UIColor (colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.8)
        self.searchController.searchResultsTableView.rowHeight = 70
        //        searchController.searchBar.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPoke = filterCollection[(indexPath as NSIndexPath).row] as! Pokemon
        self.performSegue(withIdentifier: "pokemon_detail_segue", sender: nil)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return collection.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
        
        cell.name.text = collection[(indexPath as NSIndexPath).row].name
        
        //        let imgData = NSData(contentsOfURL: collection[indexPath.row].urlImage)
        //        cell.pokeImage.image = UIImage(data: imgData!)
        
        cell.pokeImage.image = nil

        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            //            print("This is run on the background queue")
            
            let imgData = try? Data(contentsOf: self.collection[(indexPath as NSIndexPath).row].urlImage! as URL)
            
            DispatchQueue.main.async(execute: { () -> Void in
                //                print("This is run on the main queue, after the previous code in outer block")
                self.collection[(indexPath as NSIndexPath).row].image = UIImage(data: imgData!)!
                //                cell.pokeImage.image = UIImage(data: imgData!)
                cell.pokeImage.image = self.collection[(indexPath as NSIndexPath).row].image
            })
        })
        
        return cell
    }
    
    
    
    // MARK: UISearchControllerDelegate
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (collection as NSArray).filtered(using: searchPredicate)
        filterCollection = array as NSArray
        //        self.tblView.reloadData()
        self.searchController.searchResultsTableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive {
            return self.filterCollection.count
        }
        
        return 1;
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = searchController.searchResultsTableView.dequeueReusableCell(withIdentifier: "PokeTableCell", for: indexPath) as! PokemonTableViewCell
        
        
        if self.searchController.isActive {
            
            let pokemon = filterCollection[(indexPath as NSIndexPath).row] as! Pokemon
            
            cell.pokeName.text = pokemon.name
        
            
            if pokemon.image != nil {
                cell.pokeImage.image = pokemon.image
            }
            else{
                
                let qualityOfServiceClass = DispatchQoS.QoSClass.background
                let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                backgroundQueue.async(execute: {
                    //            print("This is run on the background queue")
                    
                    let imgData = try? Data(contentsOf: self.collection[(indexPath as NSIndexPath).row].urlImage! as URL)
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        cell.pokeImage.image = UIImage(data: imgData!)
                    })
                })
                
            }
        }
        
        
        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPoke = collection[(indexPath as NSIndexPath).row]
        
        self.performSegue(withIdentifier: "pokemon_detail_segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toVc:PokemonDetailViewController = segue.destination as! PokemonDetailViewController
        toVc.pokemon = selectedPoke
    }
}
