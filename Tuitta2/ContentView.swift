//
//  ContentView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var page : PageControl
    @EnvironmentObject var auth : AuthViewModel
    
    @State var showSideMenu = false
    var body: some View {
        
        if auth.userSession == nil {
            LoginView()
        } else {
            MainTabView()
        }
        
    }
    
    
    private var mainview : some View {
        ZStack(alignment: .leading) {
            
            
            MainTabView()
//            maintabview
            .zIndex(1)
            .offset( x: page.showSideMenu ? 250 : 0)
            
            sidemenu
                .offset(x: page.showSideMenu ? 0 : -250)
                .zIndex(2)
            
            
            HStack{
                VStack{
                    Spacer()
                }
                Spacer()
            }
            .background(Color.black)
            .opacity(page.showSideMenu ? 0.8 : 0)
            .zIndex(page.showSideMenu ? 1 : -0)
            .onTapGesture {
                withAnimation {
                    page.showSideMenu = false
                }
            }
        }
    }
    
    private var sidemenu : some View {
        
        SideMenuView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .font(.body.bold())
            .environmentObject(PageControl())
            .environmentObject(AuthViewModel())
    }
}
