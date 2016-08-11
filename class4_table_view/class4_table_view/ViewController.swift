//
//  ViewController.swift
//  class4_table_view
//
//  Created by Matheus Marabesi on 8/10/16.
//  Copyright © 2016 Matheus Marabesi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onViewTable(sender: AnyObject) {
        self.performSegueWithIdentifier("table_segue", sender: nil)
    }

}

