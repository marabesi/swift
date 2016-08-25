//
//  PokemonsViewController.swift
//  pokedex
//
//  Created by Jean Aparecido Chaves da Rocha on 22/08/16.
//  Copyright © 2016 Jean Rocha. All rights reserved.
//

import UIKit

private let reuseIdentifier = "pokemonViewCell"

class PokemonsViewController: UIViewController {

    var collection = [Pokemon]()
    
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
                            newPokemon.name = items.objectForKey("name")! as! String
                            newPokemon.urlImage = NSURL(string: items.objectForKey("img_url") as! String)!
                        
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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
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
                cell.pokeImage.image = UIImage(data: imgData!)
            })
        })
        
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
    
    
    
}
