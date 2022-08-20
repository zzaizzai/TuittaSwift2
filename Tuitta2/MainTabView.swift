//
//  TabView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct MainTabView: View {
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    @EnvironmentObject var page : PageControl
    
    @State var tabIndex : Int = 0
    @State var showProfileAtMainView = false
    var body: some View {
        TabView(selection: $tabIndex){
            MainPostsView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            
            NotificationView()
                .tabItem {
                    Image(systemName: "bell")
                }
                .tag(2)
            
            RecentMessagesView()
                .tabItem {
                    Image(systemName: "envelope")
                }
                .tag(3)
        }
        .accentColor(Color.black)
        .onTapGesture(count: 2) {
            if self.tabIndex == 0 {
                page.resetPage(index: 0)
            }
                

        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(PageControl())
    }
}
