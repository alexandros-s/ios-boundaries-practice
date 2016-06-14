//
//  LoadingContentViewController.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 14/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import UIKit

class LoadingContentViewController: ViewController {
    
    enum ViewState {
        case Loading
        case ContentReady
        case Error
    }
    
    var currentState:ViewState = ViewState.Loading
    
    var state:ViewState {
        get {
            return currentState
        }
        set(state) {
            if (currentState != state) {
                currentState = state
                setScreen(currentState)
            }
        }
    }
    
    func setScreen (state: ViewState) {
        switch state {
            case .Loading :
                setLoadingScreen()
            break
            default :
            return
        }
    }
    
    func setLoadingScreen() {
        let loader = UIView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.backgroundColor = UIColor(
            red: 0.75,
            green: 0.75,
            blue: 0.1,
            alpha: 0.5)
        
        view.addSubview(loader)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentState = ViewState.Loading
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}