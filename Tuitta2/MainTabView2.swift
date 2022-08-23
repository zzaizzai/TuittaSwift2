//
//  MainTabView2.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/23.
//

import SwiftUI

struct MainTabView2: View {
    @State var index = 0
    var body: some View {
        ZStack{
            if self.index == 0 {
                MainPostsView()
            } else {
                ExploreView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            tabbar
        }
    }
    
    private var tabbar : some View {
        HStack{
            Image(systemName: "person")
                .onTapGesture {
                    self.index = 0
                }
            Spacer()
            Image(systemName: "person")
                .onTapGesture {
                    self.index = 1
                }
        }
        .background(Color.white)
    }
}

struct MainTabView2_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView2()
            .environmentObject(PageControl())
            .environmentObject(AuthViewModel())
            .font(.body.bold())
    }
}
