//
//  HomeViewController.swift
//  Insulin Trainer
//
//  Created by Weston Beecroft on 11/12/14.
//  Copyright (c) 2014 Weston Beecroft. All rights reserved.
//

import Foundation
import UIKit

let main_graph_width: CGFloat = 240
let main_graph_height: CGFloat = 300

class HomeViewController: UIViewController {
    var addMenu: AddMenu!
    var graph: GraphWidget!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenBounds = UIScreen.mainScreen().bounds
        
        
        self.view.backgroundColor = MAIN_BG_COLOR
        self.navigationItem.title = "Home"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        
        self.graph = GraphWidget(frame: CGRectMake(screenBounds.size.width/2 - main_graph_width/2, 50, main_graph_width, main_graph_height))
        self.view.addSubview(self.graph)
        
        self.addMenu = AddMenu()
        self.view.addSubview(self.addMenu)
    }
    
    
    func add() {
        self.addMenu.toggle()
    }
}