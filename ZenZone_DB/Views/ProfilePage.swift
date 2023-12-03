//
//  ProfilePage.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-26.
//


// FOR HARIS - ADD AUTHENTICATION AND HANDLE REQUESTS VIA FIREBASE

import SwiftUI

struct ProfilePage: View {
//    @EnvironmentObject var dbHelper : FireDBHelper
    @EnvironmentObject var user: FireDBHelper
//    @State private var username = "User"
//    @State private var email = "user@example.com"
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(50)
            
            Text("\(user.user?.firstName ?? "") | \(user.user?.lastName ?? "") ")
            
//            Text("\(user.user?.lastName ?? "")")
            Text("\(user.user?.age ?? 0)")
            
            Text("\(user.user?.username ?? "")")
            
            Text("\(user.user?.email ?? "")")
            
            
            Button(action:{
                user.signOut()
            }) {
                Text("Sign Out")
            }
      
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
    

}
