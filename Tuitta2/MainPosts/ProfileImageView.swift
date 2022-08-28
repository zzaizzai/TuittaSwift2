//
//  ProfileImageView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageView: View {
    
    let user : User?
    
    init(user: User?) {
        self.user = user
        
    }
    @State var showProfile = false
    
    
    
    @State private var showUserProfile = false
    var body: some View {
        ZStack{
            NavigationLink("", isActive: $showProfile) {
                UserProfileView(user: self.user)
            }
            
            ZStack{
                
                if let profileImageUrl = user?.profileImageUrl {
                    WebImage(url: URL(string: profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(100)
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .background(Color.gray)
                        .frame(width: 50, height: 50)
                        .cornerRadius(100)
                }

                
            }
            .onTapGesture {
                self.showProfile = true
            }



        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileImageView(user: nil)
                .environmentObject(PageControl())
        }
    }
}
