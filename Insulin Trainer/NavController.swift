//
//  ViewController.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/12/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import UIKit

class NavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha:1.0)
        let homeViewController = HomeViewController()
        self.pushViewController(homeViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

