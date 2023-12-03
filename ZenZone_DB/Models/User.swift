//
//  User.swift
//  ZenZoneProject
//
//  Created by Muhammad Haris on 26/11/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User :  Codable{
    
    
    var firstName : String
    var lastName : String
    var age : Int?
    var username : String
    var email : String
    var password : String
    
   
}
