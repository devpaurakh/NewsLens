//
//  ProfileViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 28/01/2024.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        ApiManager.shareInstance.LogoutAPI()
        self.toLoginPage()
        
    }
    
    
    func toLoginPage(){
        let loginViewController = storyboard?.instantiateViewController(identifier: NavigationConstant.Storyboard.LoginViewController) as? LoginViewController

        // Set up a transition animation from the left
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft

        // Apply the transition animation
        view.window?.layer.add(transition, forKey: kCATransition)
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
}
