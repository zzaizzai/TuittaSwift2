//
//  ProfileImageView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI

struct ProfileImageView: View {
    @EnvironmentObject var page: PageControl
    
    @State private var showUserProfile = false
    var body: some View {
        ZStack{
            NavigationLink("", isActive: $page.showUserProfileIndex0) {
                Text("user profile from image")
            }

            Image(systemName: "person")
                .resizable()
                .background(Color.gray)
                .frame(width: 50, height: 50)
                .cornerRadius(100)
                .onTapGesture {
                    page.showUserProfileIndex0 = true
                }
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileImageView()
                .environmentObject(PageControl())
        }
    }
}
