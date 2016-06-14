//
//  MSMVCChildLoader.swift
//  BoundariesInPractice
//
//  Created by Alexandros Spyropoulos on 13/06/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import Foundation
import UIKit

protocol MSMContainer {
    func loadContent(view:UIViewController) -> UIViewController
    func loadContent(view:UIView) -> UIView
}



extension MSMContainer where Self: UIViewController {
    
    func loadContent(_viewController:UIViewController) -> UIViewController {
        let viewController = _viewController
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
        return viewController
    }
    
    func loadContent(view:UIView) -> UIView {
        self.view.addSubview(view)
        return view
    }
}
