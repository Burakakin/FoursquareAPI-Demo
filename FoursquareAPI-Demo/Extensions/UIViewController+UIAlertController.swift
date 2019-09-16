//
//  UIViewController+UIAlertController.swift
//  FoursquareAPI-Demo
//
//  Created by Burak Akin on 16.09.2019.
//  Copyright © 2019 Burak Akin. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
