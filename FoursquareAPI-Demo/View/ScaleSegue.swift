//
//  ScaleSegue.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 17.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {

    
    
    override func perform() {
        scale()
    }
    
    
    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }) { succes in
            fromViewController.present(toViewController, animated: false, completion: nil)
        }
    }
    
    
}

