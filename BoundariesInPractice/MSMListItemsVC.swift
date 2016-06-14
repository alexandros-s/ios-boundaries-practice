//
//  MSMListItemsVC.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 13/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//
import Foundation
import UIKit


enum ViewError: ErrorType {
    case NoData
}

class MSMErrorView: UIView {
    
}

class MSMListItemsVC: UIViewController, MSMContainer {
    
    
    
    func newErrorView () -> UITextView {
        let sampleTextField = UITextView(frame: CGRectMake(20, 100, 300, 40))
        sampleTextField.text = "Error"
        sampleTextField.font = UIFont.systemFontOfSize(15)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.Default
        sampleTextField.returnKeyType = UIReturnKeyType.Done
//        sampleTextField.delegate = self
        return sampleTextField
    }
    
    func newContentView () -> UITableView {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }
    
    func newContentView( fail:Bool ) -> UIView {
        guard fail == false else {
            return newErrorView()
        }
        return newContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent(newContentView(true))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
