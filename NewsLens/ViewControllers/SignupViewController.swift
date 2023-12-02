//
//  SignupViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 27/11/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
   
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var secondNameTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var signUpButtom: UIButton!
    @IBOutlet var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElement()

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
    
    func setUpElement(){
        //hiding error elemenst
        errorLabel.alpha = 0
    }
    
    //It will validtae all the form field. If all field are valid it will return nil and if the fild has incorrect value it will through error messsage
    func valitateForm()->String?{
        //checking all the field with the help of these lines of code
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            secondNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Plese Fill all fields"
        }
        //check if the password secure
        let clearPassword = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if FormValadationUtility.isPasswordValid(clearPassword) == false {
            return "At least 8 Character, contain spacial Character and a Number."
        }
        //checking if the email is well formatted or not
        let cleanEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if FormValadationUtility.isEmailValid(cleanEmail) == false{
            return "Fill the Email Field with Correct Formet"
        }
        return nil
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //Validate the field
        let error = valitateForm()
        if error != nil{
            //Showing error in the lable that I have created
            displayError(error!)
        
        }
        //create the user
        else{
            
            //create cleared version of data
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let secondname = secondNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password){(result,err)in
                //check for erros
                if err != nil {
                    //There was an error creating user
                    self.displayError("Error Creating error")
                }
                else {
                    // User was created successfully
                    let database = Firestore.firestore()
                    database.collection("users").addDocument(data: ["firstname": firstname, "lastname": secondname, "uid": result!.user.uid]) { error in
                        if let error = error {
                            // Show error message
                            self.displayError(error.localizedDescription)
                        } else {
                            // Data saved successfully
                            print("User data saved successfully")

                            // Navigate to the home screen
                            self.toLogin()
                        }
                    }
                }

            }
            
        }
        
       
 
    }
    //This function will display error if there is a error
    func displayError(_ errorMessage:String){
        errorLabel.text = errorMessage
        errorLabel.alpha = 1
        
    }
    
    func toLogin(){
    
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.LoginViewController) as? LoginViewController
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
}
