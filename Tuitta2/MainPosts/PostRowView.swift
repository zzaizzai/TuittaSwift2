//
//  PostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct PostRowView : View {
    var body: some View {
        HStack(alignment: .top){
            
            Image(systemName: "person")
                .resizable()
                .background(Color.gray)
                .frame(width: 50, height: 50)
                .cornerRadius(100)
            
            VStack(alignment: .leading) {
                HStack{
                    Text("name")
                    Text("email")
                }
                Text("text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text")
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.init(white: 0.9))
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .bottom)
        .overlay(Rectangle().frame(height: 1).foregroundColor(.init(white: 0.8)), alignment: .top)
        
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView()
            .font(.body.bold())
    }
}
