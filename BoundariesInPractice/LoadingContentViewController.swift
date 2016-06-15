//
//  LoadingContentViewController.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 14/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import UIKit

protocol Loader {
    func load()
}

class LoadingContentViewController: UIViewController, Loader {
    
    enum ViewState {
        case Idle
        case Loading
        case ContentReady
        case Error
    }
    
    let msmWhite = UIColor(
        red: 0.9,
        green: 0.9,
        blue: 0.9,
        alpha: 1)
    
    let msmBlack = UIColor(
        red: 0.1,
        green: 0.1,
        blue: 0.1,
        alpha: 1)

    var currentState:ViewState?
    
    var state:ViewState {
        get {
            return currentState!
        }
        set(state) {
            if (currentState != state) {
                currentState = state
                setScreen(currentState!)
            }
        }
    }
    
    convenience init () {
        self.init(state: ViewState.Idle)
    }
    
    init(state: ViewState) {
        super.init(nibName: nil, bundle: nil)
        self.state = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setScreen (state: ViewState) {
        switch state {
            case .Idle :
                setPendingScreen()
            break
            case .Loading :
                setLoadingScreen()
            break
            default :
            return
        }
    }
    
    
    func setContainerConstraints(viewsDictionary:[String:UIView]) {
        // set constraints
        let H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[container]|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        
        let V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[container]|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        
        // add constraints
        view.addConstraints(H)
        view.addConstraints(V)
    }
    
    func setContentConstraints(viewsDictionary:[String:UIView]) {
        // set constraints
        let H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|[content]|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        
        let V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[content(50)]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        
        // add constraints
        view.addConstraints(H)
        view.addConstraints(V)
    }
    
    func setAViewWithText (text:String, _ bgColor:UIColor, _ txtColor:UIColor) {
        let aView = UIView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.backgroundColor = bgColor
        
        let textView = UITextView(frame: UIScreen.mainScreen().bounds)
        textView.text = text
        textView.textColor = txtColor
        textView.font = UIFont.systemFontOfSize(30)
        textView.editable = false
        
        let viewsDictionary = [
            "container" : aView,
            "content" : textView
        ]
        
        //add subviews
        aView.addSubview(textView)
        view.addSubview(aView)
        
        
        setContainerConstraints(viewsDictionary)
    }
    
    func setPendingScreen () {
        setAViewWithText("Pending...", msmWhite, UIColor.blackColor())
    }
    
    func setLoadingScreen() {
        setAViewWithText("Loading...", UIColor.grayColor(), UIColor.blackColor())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = msmBlack
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // 
    
    func load () {
        state = ViewState.Loading
    }

}