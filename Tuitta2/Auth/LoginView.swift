//
//  LoginView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var auth : AuthViewModel
    var body: some View {
        NavigationView{
            VStack{
                Button {
                    auth.isLoggedOut = false
                } label: {
                    Text("login done")
                        .padding()
                }

                
                NavigationLink {
                    RegisterView()
                } label: {
                    Text("registger")
                        .padding()
                }
            }
            
        }
    }
}

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack{
            Text("registerView")
            Button {
                dismiss()
            } label: {
                Text("done")
            }

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
