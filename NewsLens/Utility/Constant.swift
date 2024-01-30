//
//  Constant.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 26/01/2024.
//

import Foundation

//MARK -> thees are all the constant that i need
let application_id = "2A11D303-7357-9F74-FF77-74A56865F300"
let app_domain = "spruceshelf.backendless.app"
let rest_api = "45BA4C20-3913-46AE-9142-1A930592A32B"
let base_url = "https://api.backendless.com/\(application_id)/\(rest_api)/users/"
let register_url = "\(base_url)register"
let login_url = "\(base_url)login"
let logout_url = "\(base_url)logout"


struct UserTokenKey {
    static let userLogin = "USER_LOGIN_KEY"
}
