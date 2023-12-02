//
//  FireDBHelper.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var userList = [User]()
    
    private static var shared : FireDBHelper?
    private var db : Firestore
    
    private let COLLECTION_USERS = "Users"
    private let COLLECTION_AUTH = "auth"
    private let ATTRIBUTE_FIRST_NAME = "firstName"
    private let ATTRIBUTE_LAST_NAME = "lastName"
    private let ATTRIBUTE_AGE = "age"
    private let ATTRIBUTE_USERNAME = "username"
    private let ATTRIBUTE_EMAIL = "email"
    private let ATTRIBUTE_PASSWORD = "password"
    
    private init(database : Firestore){
        self.db = database
    }
    
    static func getInstance() -> FireDBHelper{
        
        if(self.shared == nil){
            self.shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return self.shared!
    }
    
    
    func insertUser(user : User){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        
        do{
            if (loggedInUserEmail != "NA"){
                try self.db
                    .collection(self.COLLECTION_AUTH)
                    .document(loggedInUserEmail)
                    .collection(self.COLLECTION_USERS)
                    .addDocument(from: user)
            }else{
                print(#function, "Unable to create User. You must login first.")
            }
            
        }catch let err as NSError{
            print(#function, "Unable to insert due to error  : \(err)")
        }
    }
    
    func updateUser(indexToUpdate : Int){

        
        let documentID = self.userList[indexToUpdate].id!
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        

        
        self.db
            .collection(COLLECTION_AUTH)
            .document(loggedInUserEmail)
            .collection(COLLECTION_USERS)
            .document(documentID)
            .updateData([
                ATTRIBUTE_FIRST_NAME : self.userList[indexToUpdate].firstName,
                ATTRIBUTE_LAST_NAME : self.userList[indexToUpdate].lastName,
                ATTRIBUTE_AGE : self.userList[indexToUpdate].age,
                ATTRIBUTE_USERNAME : self.userList[indexToUpdate].username,
                ATTRIBUTE_EMAIL : self.userList[indexToUpdate].email,
                ATTRIBUTE_PASSWORD : self.userList[indexToUpdate].password
            ]){error in
                
                if let err = error {
                    print(#function, "Unable to update document due to error : \(err)")
                }else{
                    print(#function, "Document successfully updated")
                }
            }
    }
    
    func deleteUser(indexToDelete : Int){
        
        let documentID = self.userList[indexToDelete].id!
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        
        self.db
            .collection(COLLECTION_AUTH)
            .document(loggedInUserEmail)
            .collection(COLLECTION_USERS)
            .document(documentID)
            .delete{ error in
                if let err = error{
                    print(#function, "Unable to delete due to error : \(err)")
                }else{
                    print(#function, "Document deleted successfully")
                }
            }

    }

    }


    
    
    
