//
//  ContentView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI


class pagesViewModel : ObservableObject {
    @Published var tabindex = 0
}

struct ContentView: View {
    
    @EnvironmentObject var page : PageControl
    @EnvironmentObject var auth : AuthViewModel
    
    @State var showSideMenu = false
    var body: some View {
            ZStack{
                mainview
                
                
                
                Button {
                    withAnimation {
                        page.showSideMenu.toggle()
                    }
                } label: {
                    Text(page.showSideMenu.description)
                }
                .offset( y: 50)
                
                
            }.fullScreenCover(isPresented: $auth.isLoggedOut) {
                LoginView()
                
            }
    }

    
    private var mainview : some View {
        ZStack(alignment: .leading) {
            
            
//            MainTabView2()
            maintabview
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
    
    @State var tabIndex = 0
    
    private var maintabview : some View {
        ZStack{
            if vmpage.tabindex == 0 {
                MainPostsView()
            } else if vmpage.tabindex == 1 {
                ExploreView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            tabmenu
        }
    }
    
    @ObservedObject var vmpage = pagesViewModel()
    
    private var tabmenu : some View {
        
        HStack{
            Spacer()
            Image(systemName: "person.fill")
                .onTapGesture {
                    vmpage.tabindex = 0
                }
            Spacer()
            Image(systemName: "person.fill")
                .onTapGesture {
                    vmpage.tabindex = 1
                }
            Spacer()
            Image(systemName: "person.fill")
            Spacer()
            Image(systemName: "person.fill")
            Spacer()
        }
        .background(Color.white)
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
