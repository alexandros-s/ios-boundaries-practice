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
    
    var viewsConfigDictionary:[String : ViewConfig]?
    
    
    func convertConfigViewsDictionaryToViewsDictionary (cvd:[String : ViewConfig]) -> [String : UIView] {
        var viewD = [String : UIView]()
        
        
        for (key, config) in viewsConfigDictionary! {
            viewD[key] = config.view
        }
        
        return viewD

    }
    
    func sizeConstraints(viewsConfigDictionary: [String : ViewConfig])  {
        let viewsDictionary = convertConfigViewsDictionaryToViewsDictionary(viewsConfigDictionary)
     
        for (key, config) in viewsConfigDictionary {
            let view_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
                "H:[\(key)(\(config.constraint_H))]",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil, views: viewsDictionary)
            let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[\(key)(\(config.constraint_V))]",
                options: NSLayoutFormatOptions(rawValue:0),
                metrics: nil, views: viewsDictionary)
            
            view.addConstraints(view_constraint_H)
            view.addConstraints(view_constraint_V)
        }
    }
    
    func positionConstraints(viewsDictionary: [String : UIView]) {
        //position constraints
        
        //views
        let view_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[input]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDictionary)
        let view_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-36-[input]-8-[submit]-0-|",
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
    
    func setupSubmitButton (btnTitle:String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .redColor()
        button.setTitle(btnTitle, forState: .Normal)
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }
    
    func setupSubmitButton() -> UIButton {
        return setupSubmitButton("Submit")
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    func makeLayout() {
        viewsConfigDictionary = [
            "input" : ViewConfig(view: setupSearchInput(), constraint_H: "50", constraint_V: "50"),
            "submit" : ViewConfig( view: setupSubmitButton(), constraint_H: "50", constraint_V: ">=40" )
        ]
        sizeConstraints(viewsConfigDictionary!)
        positionConstraints(convertConfigViewsDictionaryToViewsDictionary(viewsConfigDictionary!))
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
}