//
//  SearchClansViewController.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 14/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import UIKit


class SearchClansViewController: UIViewController, MSMContainer {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent(SearchInputViewController())
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}