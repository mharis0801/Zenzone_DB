//
//  SignUPView.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import SwiftUI
import FirebaseAuth

struct SignupPage: View {
    var body: some View{
        VStack{
            LoginPage()
            NavigationLink("Sign Up! ", destination: SignUPView())
        }
    }
    
}


struct LoginPage: View{
    @EnvironmentObject var user: FireDBHelper
    @State private var email = ""
    @State private var password = ""
    
    var body: some View{
        VStack{
            TextField("Email",text: $email )
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("password",text: $password )
                .autocapitalization(.none)
                .disableAutocorrection(true)
            Button(action:{
                user.signIn(email: email, password: password)
                }) {
                    Text("sign IN")
                }
                .buttonStyle(.borderedProminent)
        }
    }
}

struct SignUPView: View{
    @EnvironmentObject var user: FireDBHelper
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var age = 18
    
    var body: some View{
        VStack{
            TextField("First Name",text: $firstName )
//                .autocapitalization(.none)
                .disableAutocorrection(true)
            TextField("Last Name",text: $lastName )
//                .autocapitalization(.none)
                .disableAutocorrection(true)
            Stepper("Age : \(self.age) ", value: $age, in: 10...100)
            
            TextField("username",text: $username )
                .autocapitalization(.none)
                .disableAutocorrection(true)
            TextField("Email",text: $email )
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("password",text: $password )
                .autocapitalization(.none)
                .disableAutocorrection(true)
            Button(action:{
                user.signUp(email: email, firstName: firstName, lastName: lastName, password: password, age: age, username: username)
                }) {
                    Text("sign Up")
                }
                .buttonStyle(.borderedProminent)
        }
    }
    
}

