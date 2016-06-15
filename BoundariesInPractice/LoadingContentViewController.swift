//
//  LoadingContentViewController.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 14/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

protocol Loader {
    func load()
}

protocol LoadingContentViewControllerDelegate {
    func onContentLoaded()
}

class LoadingContentViewController: UIViewController, Loader, UITableViewDelegate , UITableViewDataSource{
    
    var clans = [Clan]()
    let clansFactory = ClansFactory()
    
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
            case .ContentReady :
                setContentScreen()
            case .Error:
                setErrorScreen()
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
        
        
        let textView = UITextView(frame: UIScreen.mainScreen().bounds)
        textView.text = text
        textView.textColor = txtColor
        textView.backgroundColor = bgColor
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
    
    func setContentScreen() {
//        setAViewWithText("Content Ready...", UIColor.greenColor(), UIColor.blackColor())
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    func setErrorScreen() {
        setAViewWithText("Error...", UIColor.redColor(), UIColor.whiteColor())
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
    
    
    //Conform to DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clans.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ClanViewCell()
        let clan = self.clans[indexPath.row]
        
        cell.name = clan.name
        cell.members = String(clan.membersCount)
        cell.emblem =  clan.emblemUrl
        
        return cell
    }
    
    // Conform to Loader
    func load () {
        state = ViewState.Loading
        
        Alamofire.request(
            .GET, "https://api.worldoftanks.eu/wgn/clans/list/",
            parameters: [
                "application_id": "b791d483d27cc9c5287ea49faf6186d9",
                "search": "QSF"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let json = response.result.value {
                        let data = JSON(json)["data"]
                        if (data.error == nil) {
                            self.clans = self.clansFactory.create(data)
                            
                            self.state = ViewState.ContentReady
                        }
                        else
                        {
                            self.state = ViewState.Error
                        }
                    }
                    else
                    {
                        self.state = ViewState.Error
                    }
                case .Failure(_):
                    self.state = ViewState.Error
                }
            }
        }
    
}