//
//  CollectionViewController.swift
//  pokedex
//
//  Created by Matheus Marabesi on 8/17/16.
//  Copyright © 2016 FIAP. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {

    var collection = [Pokemon]()
    
    func loadData() {
        let name = String("asas")
        let image = UIImage(named: "pokeball")
        
        let item1 = Pokemon()
        item1.name = name
        item1.image = image!
        
        let item2 = Pokemon()
        item2.name = name
        item2.image = image!
        
        collection.append(item1)
        collection.append(item2)
        
        // let urlPath: String = "http://pokeapi.co/api/v2/pokemon/"
        let urlPath: String = "https://raw.githubusercontent.com/marabesi/swift/master/pokedex-api/pokemons.json"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    let pokes = json["pokemons"] as? NSArray
                    
                    for pokemon in pokes! {
                        let item = pokemon as! NSDictionary
                        
                        for(key, value) in item {
                            
                            let newPokemon = Pokemon()
                            
                            if (key as! String == "name") {
                                newPokemon.name = value as! String
                            }
                        }
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return collection.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        let label = cell.viewWithTag(1) as! UILabel
        let image = cell.viewWithTag(2) as! UIImageView
        
        label.text = collection[indexPath.row].name
        image.image = collection[indexPath.row].image
        
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
