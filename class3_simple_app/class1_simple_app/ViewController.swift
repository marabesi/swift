//
//  ViewController.swift
//  class1_simple_app
//
//  Created by Matheus Marabesi on 8/8/16.
//  Copyright © 2016 Matheus Marabesi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var editText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChangeView(sender: AnyObject) {
        self.performSegueWithIdentifier("view2", sender: nil)
    }
    

    @IBAction func onTouchDown(sender: AnyObject) {
        label.text = editText.text
    }
}
