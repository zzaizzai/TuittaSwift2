//
//  DetailView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var page : PageControl
    @EnvironmentObject var auth : AuthViewModel
    
    @State private var show2 = false
    
    var body: some View {
        VStack{
            
            Text("detail view")
            
            Button {
                auth.isLoggedOut = true
            } label: {
                Text("log out")
            }

            
            NavigationLink {
                Text("detail page 2")
            } label: {
                Text("detail page 2")
            }

            NavigationLink(isActive: self.$show2) {
               Text("22")
            } label: {
                Text("gogo anotehr page")
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(PageControl())
            .environmentObject(AuthViewModel())
    }
}
