//
//  Extension+UIViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 25/01/2024.
//

import Foundation
import UIKit

extension UIViewController {
    
   
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    
  
    
}
