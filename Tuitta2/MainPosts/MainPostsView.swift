//
//  MainPostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI
import Firebase

class MainPostsViewModel : ObservableObject {
    @Published var count = 0
    @Published var posts = [Post]()
    
    private let service = Service()
    
    
    init(){
        self.getPostsData()
    }
    
    
    func getPostsData() {
        
        Firestore.firestore().collection("posts").order(by: "time").getDocuments { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            
            snapshot?.documents.forEach { doc  in
                let docId = doc.documentID
                let data = doc.data()
                
                
                self.posts.insert(.init(documentId: docId, data: data), at: 0)
            }
            
            
            for i in 0 ..< self.posts.count {
                let uid = self.posts[i].authorUid
                
                self.service.getUserData(userUid: uid) { userData in
                    self.posts[i].user = userData
                }
                
            }
            
        }
    }
}

struct MainPostsView: View {
    @EnvironmentObject var page: PageControl
    @ObservedObject var vm = MainPostsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                
                
                ScrollView {
                    
                    ScrollViewReader{ ScrollViewProxy in
                        
                        
                        VStack{
                            HStack{Spacer()}
                                .id("Empty")
                            
                            VStack(spacing: 0){
                                
                                
                                ForEach(vm.posts){ post in
                                    PostRowView(post: post)
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
//                        page.showSideMenu = true
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
