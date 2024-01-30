//
//  UserAuthToken.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 29/01/2024.
//

import Foundation
import UIKit

class UserAuthToken{
    static let userTokenInstance = UserAuthToken()
    let userDefault = UserDefaults.standard
    
    func saveUserAuthToken(token:String){
        userDefault.set(token,forKey: UserTokenKey.userLogin)
        
    }
    
    func getUserAuthToken()->String{
        //this condition checking weather token is aviable or not
        if let token = userDefault.object(forKey: UserTokenKey.userLogin) as? String{
            return token
        }else{
            return ""
        }
       
    }
    
    func checkForUserLoginStatus() ->Bool{
        //checking weather the user is login or not 
        if getUserAuthToken() == ""{
            return false
        }else{
            return true
        }
    }
    
    func removerUserAuthToken(){
        
        userDefault.removeObject(forKey: UserTokenKey.userLogin)
        
    }
}
