//
//  LoginModel.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 28/01/2024.
//

import Foundation
import UIKit

struct LoginModel:Encodable{
    let login: String
    let password:String
}

struct ResponseModel: Codable {
    let lastLogin: Int
    let userStatus: String
    let created: Int
    let accountType, socialAccount, ownerID: String
    let name, welcomeClass, blUserLocale, userToken: String
    let email, objectID: String

    enum CodingKeys: String, CodingKey {
        case lastLogin, userStatus, created, accountType, socialAccount
        case ownerID = "ownerId"
        case name
        case welcomeClass = "___class"
        case blUserLocale
        case userToken = "user-token"
        case email
        case objectID = "objectId"
    }
}

