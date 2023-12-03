//
//  LoginViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 27/11/2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet var errorLable: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordTextFiel: UITextField!
    @IBOutlet var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func loginTapped(_ sender: Any) {
        //Validate textFields
        
        //signinUser
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextFiel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password){(result, error)in
            if error != nil{
                self.errorLable.text = "--User Not Found"
                self.errorLable.alpha = 1
            }
            else {
                self.toHome()
                self.saveStatus()
                
            }
        }
        //negivate to
        
    }
    
    func setUpElements(){
        //Hiding Error Lebel
        errorLable.alpha = 0
    }
    
    func toHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.HomeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
  
    
    func saveStatus(){
        UserDefaults.standard.set(true, forKey:"isLoginned")
        UserDefaults.standard.synchronize()
    }
}
