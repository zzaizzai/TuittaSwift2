//
//  ContentView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var auth : AuthViewModel
    
    var body: some View {
//        if auth.isLogged {
        ZStack{
            MainTabView()
            
        }.fullScreenCover(isPresented: $auth.isLoggedOut) {
            LoginView()
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .font(.body.bold())
            .environmentObject(PageControl())
            .environmentObject(AuthViewModel())
    }
}
