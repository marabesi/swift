//
//  DetailViewController.swift
//  FiapApp
//
//  Created by Matheus Marabesi on 8/14/16.
//  Copyright © 2016 Matheus Marabesi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var textFromTable: String?
    var imageFromTable: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = textFromTable
        image.image = imageFromTable
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

}
