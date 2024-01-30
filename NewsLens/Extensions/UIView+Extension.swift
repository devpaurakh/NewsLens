//
//  UIView+Extension.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 25/01/2024.
//

import Foundation
import UIKit

extension UIView{
  @IBInspectable  var cornerRedius:CGFloat{
      get {return self.cornerRedius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
