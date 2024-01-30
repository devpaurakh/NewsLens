//
//  LoginViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 26/01/2024.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var txtEmail: UITextField!
    private var isViewAdjustedForKeyboard = false

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var signupBtnInLoginpage: UIButton!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var txtpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        BackgroundUtility.setBackground(for: self.view) //this will help to add background Image
        initialSetup()//this is for the textfield
        
        
        disableAutocorrection(for: txtEmail)
        disableAutocorrection(for: txtpassword)
    }
    
    
    fileprivate func loginFormValidation() {
        if let email = txtEmail.text, let password = txtpassword.text{
            if email == ""{
                
                openAlert(title: "Alert", message: "Fill the all Fields", alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default], actions: [{ _ in
                    print("OK clicked")
                }])
                
            }else{
                if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default], actions: [{ _ in
                        print("OK clicked")
                    }])
                    
                }else if !password.validatePassword(){
                    
                    openAlert(title: "Alert", message: "email or password not found ", alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default], actions: [{ _ in
                        print("OK clicked")
                    }])
                    
                    
                }else{
                    activityIndicator.startAnimating()
                    let login = LoginModel(login: email, password: password)
                    ApiManager.shareInstance.LoginAPI(login: login) { (result) in
                        // Hide the activity indicator when the operation completes
                        DispatchQueue.main.async {
                          self.activityIndicator.stopAnimating()
                        }

                       
                        switch result{
                        case .success(let json):
                            print(json!)
                            _ = (json as! ResponseModel).name
                            _ = (json as! ResponseModel).email
                            //Saving the token in the userdefault in the login button clicked
                            let userAuthToken = (json as! ResponseModel).userToken
                            UserAuthToken.userTokenInstance.saveUserAuthToken(token: userAuthToken)
                        case .failure(let err):
                            print(err.localizedDescription)
                            
                        }
                        //Navigation - Home
                        self.toHome()
                       
                        
                        
                    }
                }
                
                
            }
        }else{
            
            openAlert(title: "Alert", message: "Please check the field", alertStyle: .alert, actionTitles: ["Okey"], actionStyles: [.default], actions: [{ _ in
                print("OK clicked")
            }])
            
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
        loginFormValidation()
    }
    
   
    private func initialSetup() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (loginBtn.frame.origin.y + loginBtn.frame.height)
            
            if !isViewAdjustedForKeyboard {
                self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
                isViewAdjustedForKeyboard = true
            }
        }
    }

    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
        isViewAdjustedForKeyboard = false
    }

   

    @IBAction func signUpinLoginPageTapped(_ sender: UIButton) {
        
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
    
    //It will negiavte to the home with dissolving
    func toHome(){
        
        let homeTabBarController = storyboard?.instantiateViewController(identifier: NavigationConstant.Storyboard.HomeTabBarController) as? HomeTabBarController

        // Set up a transition animation from the left
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight

        // Apply the transition animation
        view.window?.layer.add(transition, forKey: kCATransition)
        view.window?.rootViewController = homeTabBarController
        view.window?.makeKeyAndVisible()

    }
    
    //This funtion will help in the disbling the autocorrection
    func disableAutocorrection(for textField: UITextField) {
             textField.autocorrectionType = .no
         }

    
}
