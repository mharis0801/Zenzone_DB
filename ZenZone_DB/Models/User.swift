//
//  User.swift
//  ZenZoneProject
//
//  Created by Muhammad Haris on 26/11/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Identifiable, Hashable, Codable{
    
    @DocumentID var id : String? = UUID().uuidString
    
    var firstName : String
    var lastName : String
    var age : Int?
    var username : String
    var email : String
    var password : String
    
    init(){
        self.firstName = "NA"
        self.lastName = "NA"
        self.age = 18
        self.username = "abc"
        self.email = "test@mail.com"
        self.password = "1234pass"
    }
    
    init(firstName: String, lastname : String , age: Int, username: String, email: String, password: String){
        
        self.firstName = firstName
        self.lastName = lastname
        self.age = age
        self.username = username
        self.email = email
        self.password = password
    }
    
}
