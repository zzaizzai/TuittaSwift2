//
//  MainPostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct MainPostsView: View {
    @EnvironmentObject var page: PageControl
    @State private var showProfile = false
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
    
            NavigationView {
                ScrollView {
                    VStack(spacing: 0){
                        
                        PostRowView()
                        PostRowView()
                        PostRowView()
                        PostRowView()
                        PostRowView()
                        PostRowView()
                        PostRowView()
                        
                    }
                }
                .navigationBarHidden(true)
                .safeAreaInset(edge: .top) {
                    navbar
                }
                .fullScreenCover(isPresented: $showNewPost) {
                    NewPostView()
                }
            }

            
            newPostButton
        }
    }
    
    @State private var showNewPost = false
    
    private var newPostButton: some View {
        
        ZStack{
            
                Button {
                    self.showNewPost = true
                    
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
            
            
            Spacer()
            
            Text("navbar")
            Spacer()
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
