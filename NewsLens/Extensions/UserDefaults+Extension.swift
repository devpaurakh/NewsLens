//
//  UserDefaults+Extension.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 25/01/2024.
//

import Foundation

extension UserDefaults{
    private enum UserDefaultKeys: String{
        case hasOnBoarded
        case isLogined
    }
    var hasOnBoarded:Bool{
        get {
            bool(forKey: UserDefaultKeys.hasOnBoarded.rawValue)
            
        }
        set{
            setValue(newValue, forKey: UserDefaultKeys.hasOnBoarded.rawValue)
        }
    }
    
    var isLogined:Bool{
        get {
            bool(forKey: UserDefaultKeys.isLogined.rawValue)
            
        }
        set{
            setValue(newValue, forKey: UserDefaultKeys.isLogined.rawValue)
        }
    }
    
   
    
  
}
