//
//  SideMenuView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var page : PageControl
    @EnvironmentObject var auth : AuthViewModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            VStack(spacing: 15) {
                
                Button {
                    withAnimation {
                        page.showSideMenu = false
                        page.showMyProfileIndex0 = true
                    }
                } label: {
                    HStack(spacing: 0) {
                        Text("profile")
                            .font(.title.bold())
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    HStack{
                        Text("log out")
                            .font(.title.bold())
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                

                
            }
            .padding(.horizontal)
            .padding(.top)
            
            
        }
        .frame(width: 250)
        .safeAreaInset(edge: .top, content: {
            topview
        })
        .safeAreaInset(edge: .bottom) {
            bottombar
        }
        .background(Color.init(white: 0.7))
    }
    private var topview : some View {
        LazyVStack(alignment: .leading, spacing: 0){
            
            Group{
                Image(systemName: "person")
                    .resizable()
                    .background(Color.gray)
                    .frame(width: 50, height: 50)
                    .cornerRadius(100)
                    .onTapGesture {
                    
                        withAnimation {
                            page.showSideMenu = false
                            page.showMyProfileIndex0 = true
                        }
                    }
                
                
                Text("name")
                    .font(.system(size: 30))
                
                Text("email")
                
                HStack{
                    Text("follow")
                }
                .padding(.vertical)
                
            }
            .padding(.horizontal)
        }
        .frame(width: 250)
        .background(Color.init(white: 0.7))
    }
    private var bottombar : some View {
        HStack{
            Spacer()
        }
        .frame(width: 250, height: 45)
        .background(Color.init(white: 0.5))
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
            SideMenuView()
                .font(.body.bold())
                .environmentObject(PageControl())
                .environmentObject(AuthViewModel())
    
    }
}
