//
//  MainTabView2.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/23.
//

import SwiftUI

struct MainTabView2: View {
    @EnvironmentObject var page : PageControl
    @State var index = 0
    var body: some View {
        ZStack{
            switch page.tabIndex {
            case 0 :
                MainPostsView()
            case 1 :
                ExploreView()
            
            default:
                MainPostsView()
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            tabbar
        }
    }
    
    private var tabbar : some View {
        HStack{
            Spacer()
            Image(systemName: "person")
                .onTapGesture {
                    page.tabIndex = 0
                }
            Spacer()
            Image(systemName: "person")
                .onTapGesture {
                    page.tabIndex = 1
                }
            Spacer()
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
