//
//  SignupViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 26/01/2024.
//

import UIKit

class SignupViewController: UIViewController {
    private var isViewAdjustedForKeyboard = false

    @IBOutlet var loginBtnInSignUpage: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtemail: UITextField!
    @IBOutlet var txtSecondName: UITextField!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var signupBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackgroundUtility.setBackground(for: self.view) //this will help to add background Image
        initialSetup()//this is for the textfield
        
        //Disabling the auto Corretion in the textfields
        disableAutocorrection(for: txtFirstName)
        disableAutocorrection(for: txtSecondName)
        disableAutocorrection(for: txtemail)
        disableAutocorrection(for: txtPassword)
    }
    

    @IBAction func SignUpButton(_ sender: Any) {
        //in email firstname, secondname will cut space if there is any
        if let email = txtemail.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let firstName = txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let secondName = txtSecondName.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = txtPassword.text {
            
            if !email.validateEmailId() {
                openAlert(title: "Alert", message: "Enter Valid Email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("OK clicked")
                }])
            } else if !password.validatePassword() {
                openAlert(title: "Alert", message: "Minimum 8 characters and special characters not allowed", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("OK clicked")
                }])
            } else if !firstName.isAlphabetic() {
                openAlert(title: "Alert", message: "First Name should only contain alphabetic characters", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("OK clicked")
                }])
            } else if !secondName.isAlphabetic() {
                openAlert(title: "Alert", message: "Second Name should only contain alphabetic characters", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("OK clicked")
                }])
            }
            else{
            
                let fullName = firstName + " " + secondName
                //navigation code
                let register = RegisterModel(name: fullName, email: email, password: password)
                ApiManager.shareInstance.registerAPI(register: register) { (isSuccess, message) in
                    
                    if isSuccess{
                        self.openAlert(title: "Alert", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            self.toLoginPage()
                        }])
                        //this will navigateto the login page
                        
                    }else{
                        self.openAlert(title: "Alert", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            print("OK clicked")
                        }])
                    }
                    
                    
                }
                
               
            }
            
        } else {
            openAlert(title: "Alert", message: "Fill in all fields", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("OK clicked")
            }])
        }

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
            let bottomSpace = self.view.frame.height - (signupBtn.frame.origin.y + signupBtn.frame.height)
            
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
    
    
    @IBAction func loginBtnInSignUpageTapped(_ sender: UIButton) {
        
        self.toLoginPage()

        //End Of Animation
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
    
    
    //This funtion will help in the disbling the autocorrection
    func disableAutocorrection(for textField: UITextField) {
             textField.autocorrectionType = .no
         }

    
}
