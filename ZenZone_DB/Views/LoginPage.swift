//
//  SignInView.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    
    @Binding var rootView : RootView
    
    @State private var email : String = "user1@gmail.com"
    @State private var password : String = "pass1234"
    
    var body: some View {
        VStack{
            
            Form{
                
                
                TextField("email address ", text: $email)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                
                
                SecureField("password", text: $password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                HStack{
                    Button(action: {
                        //validate inputs
                        
                        //login using FirebaseAuth
                        self.login()
                    }){
                        Text("Login")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {
                        //validate inputs
                        
                        //login using FirebaseAuth
                        self.signUp()
                    }){
                        Text("signUP")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
                
                
                //Task - provide a button to go to SignUpView
                //send the rootView as binding variable
            }
            
            Spacer()
            
        }
        
    }//body
    
    private func login(){
        Auth.auth().signIn(withEmail: self.email, password: self.password){ authResult, error in
            
            guard let result = authResult else{
                print(#function, "Unable to sign in due to error : \(error)")
                return
            }
            
            print(#function, "authResult : \(authResult)")
            
            switch(authResult){
            case .none:
                print(#function, "Unsuccesful sign in attempt")
            case .some(_):
                print(#function, "Login successful")
                
                if (authResult != nil){
                    print(#function, "user info Email : \(authResult!.user.email)")
                    print(#function, "user info Name : \(authResult!.user.displayName)")
                }
                
                UserDefaults.standard.set(authResult!.user.email, forKey: "KEY_EMAIL")
                
                //modify the root view value to replace the SignInView() with MainView in the NavigationStack
                self.rootView = .main
            }
            
        }
    }
    private func signUp(){
        self.rootView = .signup
    }
}
