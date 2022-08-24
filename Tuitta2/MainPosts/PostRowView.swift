//
//  PostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct PostRowView : View {
    
    @EnvironmentObject var page: PageControl
    
    var post : Post?
    
    @State private var showDetail = false
    var body: some View {
        HStack(alignment: .top){
            
//            Image(systemName: "person")
//                .resizable()
//                .background(Color.gray)
//                .frame(width: 50, height: 50)
//                .cornerRadius(100)
            ProfileImageView()
            
            VStack(alignment: .leading) {
                HStack{
                    Text("name")
                    Text("email")
                }
                Text("text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text")
                
                HStack{
                    Image(systemName: "message")
                    Text("22")
                    Spacer()
                    Image(systemName: "arrow.2.squarepath")
                    Text("22")
                    Spacer()
                    Image(systemName: "heart")
                    Text("22")
                    Spacer()
                }
                
            }
            
            Spacer()
            
            
            NavigationLink("", isActive: $page.showDetailIndex0) {
                Text("show detail page")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.init(white: 0.9))
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .bottom)
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .top)
        .onTapGesture {
            page.showDetailIndex0 = true
            
        }
        
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostRowView(post: nil)
                .environmentObject(PageControl())
            .font(.body.bold())
        }
    }
}
