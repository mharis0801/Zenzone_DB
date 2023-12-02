//
//  ProfilePage.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-26.
//


// FOR HARIS - ADD AUTHENTICATION AND HANDLE REQUESTS VIA FIREBASE

import SwiftUI

struct ProfilePage: View {
    @State private var username = "User"
    @State private var email = "user@example.com"
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(50)
            
            Text(username)
                .font(.title)
            
            Text(email)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
    

}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
