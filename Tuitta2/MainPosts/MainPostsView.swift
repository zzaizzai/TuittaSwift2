//
//  MainPostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

class MainPostsViewModel : ObservableObject {
    @Published var count = 0
}

struct MainPostsView: View {
    @EnvironmentObject var page: PageControl
    @ObservedObject var vm = MainPostsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                
                
//                NavigationLink("", isActive: $page.showPostIndex0) {
//                    PostDetailView()
//                }
                
                
                ScrollView {
                    
                    ScrollViewReader{ ScrollViewProxy in
                        
                        
                        VStack{
                            HStack{Spacer()}
                                .id("Empty")
                            
                            VStack(spacing: 0){
                                
                                
                                ForEach(0 ..< 100){ item in
                                    PostRowView()
                                }
                                
                            }
                            .onReceive(page.$countIndex0) { xx in
                                withAnimation(.easeOut(duration: 0.2)) {
                                    ScrollViewProxy.scrollTo("Empty", anchor: .top)
                                }
                            }
                        }


                        

                    }


                }
                .navigationBarHidden(true)
                .safeAreaInset(edge: .top) {
                    navbar
                }
                .fullScreenCover(isPresented: $showNewPost) {
                    NewPostView()
                }
                
                
                newPostButton
            }
        }
    }
    
    @State private var showNewPost = false
    
    private var newPostButton: some View {
        
        ZStack{
            
            Button {
                self.showNewPost = true
//                page.countIndex0 += 1
                
            } label: {
                Image(systemName: "plus")
                
            }
            .foregroundColor(Color.white)
            .font(.system(size: 30))
            .padding()
            .background(Color.blue)
            .cornerRadius(100)
            .padding()
            .offset( y: -20)
            
        }
    }
    
    private var navbar : some View {
        HStack{
            Image(systemName: "person")
                .resizable()
                .background(Color.gray)
                .frame(width: 30, height: 30)
                .cornerRadius(100)
                .padding()
                .onTapGesture {
                    withAnimation {
                        page.showSideMenu = true
                    }
                }
            
            Spacer()
            
            Text(page.countIndex0.description)
        }
        .frame(height: 40)
        .background(Color.white.opacity(0.9))
    }
    
}



struct MainPostView_Previews: PreviewProvider {
    static var previews: some View {
        //        MainPostsView()
        ContentView()
            .font(.body.bold())
            .environmentObject(PageControl())
            .environmentObject(AuthViewModel())
    }
}
