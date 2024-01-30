//
//  String+Extension.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 26/01/2024.
//

import Foundation
import UIKit

extension String{
    
    
    //Regax for email
    func validateEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    //Regax for password
    func validatePassword(mini: Int = 8, max: Int = 12) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        var passRegEx = ""
        if mini >= max{
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
        }else{
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func isAlphabetic() -> Bool {
            return rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
        } 
    
    
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
    
  

}
