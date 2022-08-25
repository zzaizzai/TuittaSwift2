//
//  LoginView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI
import Firebase


struct LoginView: View {
    
    @EnvironmentObject var auth : AuthViewModel
    
    @State var email = "test@test.com"
    @State var password = "password"
    
    var body: some View {
        NavigationView{
            VStack{
                
                Group {
                    TextField("email", text: $email)
                    TextField("password", text: $password)
                }
                .padding()
                .background(Color.init(white: 0.9))
                .cornerRadius(20)
                .padding()
                
                
                if self.email.isEmpty || self.password.isEmpty {
                    
                    HStack{
                        Spacer()
                        Text("Log In")
                            .foregroundColor(Color.init(white: 0.5))
                            .padding()
                        Spacer()
                    }
                    .background(Color.init(red: 0.3, green: 0.4, blue: 0.1))
                    .cornerRadius(20)
                    .padding()
                    
                } else {
                    Button {
                        auth.login(email: self.email, password: self.password)
                    } label: {
                        HStack{
                            Spacer()
                            Text("Log In")
                                .foregroundColor(Color.white)
                                .padding()
                            Spacer()
                        }
                    }
                    .background(Color.init(red: 0.3, green: 0.4, blue: 0.1))
                    .cornerRadius(20)
                    .padding()
                }

                
                
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
