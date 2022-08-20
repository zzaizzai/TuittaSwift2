//
//  SideMenuView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            ScrollView {
                
                Button {
                    
                } label: {
                    HStack(spacing: 0) {
                        Text("menu")
                            .font(.title.bold())
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    HStack{
                        Text("log out")
                            .font(.title.bold())
                            .foregroundColor(Color.white)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
                
            }
            
            
        }
        .frame(width: 250, height: .infinity)
        .safeAreaInset(edge: .top, content: {
            topview
        })
        .safeAreaInset(edge: .bottom) {
            bottombar
        }
        .background(Color.gray)
    }
    private var topview : some View {
        LazyVStack(alignment: .leading){
            
            Group{
                Text("profile")
                Text("profile")
                Text("profile")
                
            }
            .padding()
        }
        .frame(width: 250)
        .background(Color.green)
    }
    private var bottombar : some View {
        HStack{
            Text("ss")
        }
        .frame(width: 250)
        .background(Color.init(white: 0.8))
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
            .font(.body.bold())
    }
}
