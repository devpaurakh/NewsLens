//
//  WelcomeViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 25/01/2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let backgroundImageView = UIImageView()

    @IBOutlet var signupNav: UIButton!
    @IBOutlet var loginNav: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundUtility.setBackground(for: self.view) //this will help to add background Image
    }
    

    @IBAction func toLoginPage(_ sender: Any) {
        
        let loginViewController = storyboard?.instantiateViewController(identifier: NavigationConstant.Storyboard.LoginViewController) as? LoginViewController

        // Set up a transition animation from the left
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight

        // Apply the transition animation
        view.window?.layer.add(transition, forKey: kCATransition)
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func toSignupPage(_ sender: Any) {
        
        let loginViewController = storyboard?.instantiateViewController(identifier: NavigationConstant.Storyboard.SignupViewController) as? SignupViewController

        // Set up a transition animation from the left
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight

        // Apply the transition animation
        view.window?.layer.add(transition, forKey: kCATransition)
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
  
}
    
  


