//
//  ClanViewCell.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 15/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import UIKit
import AlamofireImage

class ClanViewCell: UITableViewCell {
    
    var nameView: UILabel!
    var membersView: UILabel!
    var emblemView: UIImageView!
    var emblemUrl:NSURL!
    
    var name:String {
        get {
            return nameView.text!
        }
        set(text) {
            nameView.text = text
        }
    }
    
    var members:String {
        get {
            return membersView.text!
        }
        set(text) {
            membersView.text = text
        }
    }
    
    var emblem:NSURL {
        get {
            return emblemUrl
        }
        set(url) {
            emblemUrl = url
            emblemView.af_setImageWithURL(emblemUrl) { image in
                print("\(image)")
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 10
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 150
        let lineGap : CGFloat = 5
        let label2Y : CGFloat = gap + labelHeight + lineGap
        let imageSize : CGFloat = 50
        
        let x:CGFloat = 0.0//bounds.width-imageSize - gap
        let y:CGFloat = 0.0//gap
        emblemView = UIImageView(frame : CGRectMake(x, y, imageSize, imageSize))
        contentView.addSubview(emblemView)
        
        nameView = UILabel()
        nameView.frame = CGRectMake(imageSize + gap, gap, labelWidth, labelHeight)
        nameView.textColor = UIColor.blackColor()
        contentView.addSubview(nameView)
        
        membersView = UILabel()
        membersView.frame = CGRectMake(imageSize + (gap * 2) + labelWidth, gap, labelWidth, labelHeight)
        membersView.textColor = UIColor.blackColor()
        contentView.addSubview(membersView)
        
       
    }
    
}
