//
//  NavigationHelper.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 28/01/2024.
//

import Foundation
import UIKit


class NavigationHelper {
    static func navigateToViewController(_ viewController: UIViewController, from sourceViewController: UIViewController) {
        print("Navigating to view controller")
        sourceViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
  
}
