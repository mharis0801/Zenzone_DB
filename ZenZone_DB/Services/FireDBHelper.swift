//
//  FireDBHelper.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FireDBHelper : ObservableObject{
    @Published var user: User?
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    var uuid : String? {
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool{
        auth.currentUser != nil
    }
    var userIsAuthenticatedAndSynced: Bool{
        user != nil && userIsAuthenticated
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{return}
            DispatchQueue.main.async{
                self?.sync()
            }
            
        }
    }
    
    
    func signUp (email: String, firstName: String, lastName: String, password: String, age: Int, username : String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{return}
            DispatchQueue.main.async{
                self?.add(User(firstName: firstName, lastName: lastName, username: username, email: email, password: password))
                self?.sync()
            }
        }
    }
    
    func signOut(){
        do{
            try auth.signOut()
            self.user = nil
        } catch {
            print("Error signing out user: \(error)")
        }
    }
    
    private func sync(){
        guard userIsAuthenticated else{return}
        db.collection("users").document(self.uuid!).getDocument {(document, error)in
            guard document != nil, error == nil else {return}
            do{
                try self.user = document!.data(as: User.self)
            } catch {
                print("stnc error : \(error)")
            }
        }
    }
    
    private func add(_ user: User){
        guard userIsAuthenticated else { return}
        do{
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
            
        } catch{
            print("error add: \(error)")
        }
    }
    
    private func update(){
        guard userIsAuthenticatedAndSynced else {return}
        do{
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
            
        } catch{
            print("error updating \(error)")
        }
    }
}
