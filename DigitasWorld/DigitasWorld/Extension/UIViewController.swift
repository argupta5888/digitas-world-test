//
//  UIViewController.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showError(msg: String) -> Void {
        let alert = UIAlertController(title: "MESSAGE", message: msg, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOK)
        self.present(alert, animated: true, completion: nil)
    }
}
