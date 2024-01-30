//
//  ApiManager.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 26/01/2024.
//

import Foundation
import Alamofire
import UIKit


class ApiManager{
    static let shareInstance = ApiManager()
    
    //MARK -> this code will help in the signup
    func registerAPI(register:RegisterModel, compeletionHandelar:@escaping(Bool,String)->()){
        let headers:HTTPHeaders = [
            .contentType("application/json")]
        
        AF.request(register_url,method: .post, parameters: register,encoder: JSONParameterEncoder.default,headers: headers).response{ response in debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do{
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        compeletionHandelar(true, "Account Created Succesfully")
                    }else{
                        compeletionHandelar(false,"User is Already Exist")
                    }
                }catch{
                    print(error.localizedDescription)
                    compeletionHandelar(false, "User is Already Exist")
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
                compeletionHandelar(false, "User is Already Exist")
                
            }
        
        }
    }
    
    
    //MARK -> this code will responsable for the Logimn
    
    func LoginAPI(login:LoginModel, comletionHandler: @escaping Handler_Constant.Handler){
        let headers:HTTPHeaders = [
            .contentType("application/json")]
        
        AF.request(login_url,method: .post, parameters: login,encoder: JSONParameterEncoder.default,headers: headers).response{ response in debugPrint(response)
            
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONDecoder().decode(ResponseModel.self, from: data!)
                    print(json)
                    if response.response?.statusCode == 200{
                        comletionHandler(.success(json))
                    }else{
                        comletionHandler(.failure((.custom(message: "Please check your newtowk connectivity"))))
                    }

                }catch{
                    print(error.localizedDescription)
                    comletionHandler(.failure(.custom(message: "Invalid login or password")))
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
                comletionHandler(.failure(.custom(message: "User Already Exist")))
                
            }
        
        }
    }
    
    
    func LogoutAPI(){
        let headers:HTTPHeaders = [
            "user-token": "\(UserAuthToken.userTokenInstance.getUserAuthToken())"
        ]
        AF.request(logout_url, method: .get, headers: headers).response{
         response in debugPrint(response)
            
            switch response.result{
            case .success(_):
                UserAuthToken.userTokenInstance.removerUserAuthToken()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    
    
    
}
