//
//  ViewController.swift
//  class4
//
//  Created by Matheus Marabesi on 8/10/16.
//  Copyright © 2016 Matheus Marabesi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogoutFail(sender: AnyObject) {
        self.performSegueWithIdentifier("authenticate_back_fail_segue", sender: nil)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        self.performSegueWithIdentifier("authenticate_back_ok_segue", sender: nil)
    }
    
    @IBAction func onTouchUpInside(sender: AnyObject) {
        if (login.text == "test" && password.text == "test") {
            self.performSegueWithIdentifier("authenticate_ok_segue", sender: nil)
        } else {
            self.performSegueWithIdentifier("authenticate_fail_segue", sender: nil)
        }
    }
}

