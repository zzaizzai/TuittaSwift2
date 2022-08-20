//
//  PostDetailView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI

class PostDetailViewModel : ObservableObject {
    @Published var chatText = ""
}

struct PostDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var vm = PostDetailViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "person")
                        .resizable()
                        .background(Color.gray)
                        .frame(width: 50, height: 50)
                        .cornerRadius(100)
                    VStack(alignment: .leading) {
                        HStack{
                            Text("name")
                            Spacer()
                            
                            Text("...")
                        }
                        Text("email")
                    }
                    
                    
                }
                
                Text("content content content content content content")
                    .font(.title2.bold())
            }
            .padding(.horizontal)
            
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top, content: {
            topview
        })
        .safeAreaInset(edge: .bottom) {
            bottomview
        }
    }
    
    private var topview: some View {
        HStack{
            Button {
                dismiss()
            } label: {
                Text("Cancle")
                    .padding()
                    .foregroundColor(Color.black)
            }
            
            Spacer()
            
            
        }
        .frame(height: 40)
        .background(Color.init(white: 0.9).opacity(0.8))
    }
    private var bottomview : some View {
        
        HStack{
            TextField("chat", text: $vm.chatText)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(Color.init(white: 0.8))
                .cornerRadius(30)
                .padding()
        }
        .background(Color.init(white: 0.95))
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
            .font(.body.bold())
    }
}
