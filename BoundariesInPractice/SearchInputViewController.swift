//
//  SearchInputViewController.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 14/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import UIKit

struct ViewConfig {
    let view:UIView
    let constraint_H:String
    let constraint_V:String
}

class SearchInputViewController: UIViewController, MSMContainer, UITextFieldDelegate {
    
    var content:UIViewController?
    
    
    func sizeConstraints(viewsDictionary: [String : UIView], metricsDictionary: [String: AnyObject])  {
     
        
            let inputView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|[input]|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: metricsDictionary,
                views: viewsDictionary)
            let inputView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[input(inputHeight)]",
                options: NSLayoutFormatOptions(rawValue:0),
                metrics: metricsDictionary,
                views: viewsDictionary)
        
        
            let contentView_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|[content]|",
                options: NSLayoutFormatOptions(rawValue:0),
                metrics: metricsDictionary,
                views: viewsDictionary)
        
            let contentView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[content(>=contentHeight)]",
                options: NSLayoutFormatOptions(rawValue:0),
                metrics: metricsDictionary,
                views: viewsDictionary)
        
            
            view.addConstraints(inputView_constraint_H)
            view.addConstraints(inputView_constraint_V)
            view.addConstraints(contentView_constraint_H)
            view.addConstraints(contentView_constraint_V)
        
    }
    
    func positionConstraints(viewsDictionary: [String : UIView]) {
        //position constraints
        
        //views
        let view_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[input]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-36-[input]-8-[content]-0-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil, views: viewsDictionary)
        
        view.addConstraints(view_constraint_H)
        view.addConstraints(view_constraint_V)
    }
    
    func setupSearchInput (placeHolder: String) -> UITextField {
        let textField = UITextField(frame: CGRectMake(20, 100, 300, 40))
        textField.placeholder = placeHolder
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.keyboardType = UIKeyboardType.Default
        textField.returnKeyType = UIReturnKeyType.Done
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        self.view.addSubview(textField)
        return textField
    }
    
    func setupSearchInput() -> UITextField  {
        return setupSearchInput("Enter text here")
    }
    
    
    func setupLoadingContent() -> UIViewController {
        let content = loadContent(LoadingContentViewController())
        content.view.translatesAutoresizingMaskIntoConstraints = false
        return content
    }
    
    func makeLayout() {
        content = setupLoadingContent()
        
        let viewsDictionary:[String:UIView] = [
            "input" :setupSearchInput(),
            "content" : content!.view
        ]
        
        let metrics: [String:AnyObject] = [
            "inputHeight" : 40,
            "contentHeight" : 50
        ]
        
        sizeConstraints(viewsDictionary, metricsDictionary: metrics)
        positionConstraints(viewsDictionary)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TextField Delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool  {
        guard content != nil else {
            return false
        }
        
        if let loader = content as? Loader {
            loader.load()
            return true
        }
        
        return false
    }
}