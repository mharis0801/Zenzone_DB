//
//  LaunchView.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var rootView : RootView = .login
    let fireDBHelper : FireDBHelper = FireDBHelper.getInstance()
    
    var body: some View {
        NavigationStack{
            
            switch self.rootView{
            case .signup:
                SignupPage(rootView: self.$rootView).environmentObject(self.fireDBHelper)
            case .login:
                LoginPage(rootView: self.$rootView)
            case .main:
                HomePageView(rootView: self.$rootView).environmentObject(self.fireDBHelper)
            
                
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
