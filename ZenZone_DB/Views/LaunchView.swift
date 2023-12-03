//
//  LaunchView.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import SwiftUI

struct LaunchView: View {
    
//    @State private var rootView : RootView = .login
//    let fireDBHelper : FireDBHelper = FireDBHelper
    @EnvironmentObject var user : FireDBHelper
    
    var body: some View {
        NavigationView{
            if user.userIsAuthenticatedAndSynced{
                    HomePageView()
            }else {
                SignupPage()
            }
            }
        }
    }

//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchView()
//    }
//}
