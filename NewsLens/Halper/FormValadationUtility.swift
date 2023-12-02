//
//  FormValadationUtility.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 02/12/2023.
//

import Foundation
import UIKit

class FormValadationUtility{
    static func isPasswordValid(_ password:String)->Bool{
        let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@",passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    static func isEmailValid(_ email:String)->Bool{
        let emailRegexEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@",emailRegexEx)
        return emailTest.evaluate(with: email)
    }
}
