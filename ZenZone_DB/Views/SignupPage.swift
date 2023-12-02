//
//  SignUPView.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import SwiftUI
import FirebaseAuth

struct SignupPage: View {
    
    @Binding var rootView : RootView
    @EnvironmentObject var dbHelper : FireDBHelper
    @Environment(\.dismiss) var dismiss
    
   @State var firstName : String = ""
    @State var lastName : String = ""
    @State var age : Int = 18
    @State var username : String = ""
    @State  var email : String = ""
    @State var password : String = ""
    @State var goBack = false
    
    var body: some View {
        VStack{
            
            Form{
                TextField("First Name:  ", text: $firstName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                TextField("Last Name:  ", text: $lastName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                Stepper("age: \(age) ", value: $age)
                    .padding()
                
                TextField("email address ", text: $email)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                TextField("Username:  ", text: $username)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                
                
                
                SecureField("password", text: $password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                Button(action: {
                    //validate inputs
                    
                    //create account using firebaseAuth
                    self.createAccount()
                    
                    self.addUser()
                }){
                    Text("Create Account")
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    //validate inputs
                    
                    //create account using firebaseAuth
                    self.loginPage()
                }){
                    Text("Back to Sign In ")
                }
                .buttonStyle(.borderedProminent)
                
                
                
            }
            
            Spacer()
            
        }
        .padding()
    }//body
    
    private func createAccount(){
        Auth.auth().createUser(withEmail: self.email, password: self.password){ authResult, error in
            
            guard let result = authResult else{
                print(#function, "Unable to create user due to error : \(error)")
                return
            }
            
            print(#function, "authResult : \(authResult)")
            
            switch(authResult){
            case .none:
                print(#function, "Account creation denied")
            case .some(_):
                print(#function, "Account creation successful")
                
                if (authResult != nil){
                    print(#function, "user info Email : \(authResult!.user.email)")
                }
                
                UserDefaults.standard.set(authResult!.user.email, forKey: "KEY_EMAIL")
                
                self.rootView = .login
                
                //optionally - create User document in the Firestore which can have all the profile information
                //profile screen will allow the user to enter or update profile information
            }
            
        }
    }
    
    private func addUser(){
        let newUser = User(firstName: self.firstName, lastname: self.lastName, age: self.age, username: self.username, email: self.email, password: "*****")
        self.dbHelper.insertUser(user: newUser)
        dismiss()
    }
    
    private func loginPage(){
        self.rootView = . login
    }
}

