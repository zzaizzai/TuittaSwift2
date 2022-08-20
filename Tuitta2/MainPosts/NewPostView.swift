//
//  NewPostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI

class NewPostViewModel : ObservableObject {
    
    @Published var uploadText = "11"
}

struct NewPostView: View {
    
    @ObservedObject var vm = NewPostViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ScrollView{
                HStack(alignment: .top){
                    Image(systemName: "person")
                        .resizable()
                        .background(Color.gray)
                        .frame(width: 50, height: 50)
                        .cornerRadius(100)
                    
                    LazyVStack(alignment: .leading){
                        TextEditor(text: $vm.uploadText)
                            .frame(height: 400)
                            
                    }
                    
                }
                .padding(.horizontal, 5)
                
            }
            
            
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top) {
            topbar
        }
    }
    
    private var topbar : some View {
        HStack{
            Button {
                dismiss()
            } label: {
                Text("Cancle")
                    .padding()
                    .foregroundColor(Color.black)
            }
            
            
            Spacer()
            
            if vm.uploadText.isEmpty {
                Text("Upload")
                    .foregroundColor(Color.gray)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(Color.blue)
                    .cornerRadius(30)
                    .padding(.horizontal, 10)
                
            } else {
                Button {
                    
                } label: {
                    Text("Upload")
                        .foregroundColor(Color.white)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
                .background(Color.blue)
                .cornerRadius(30)
                .padding(.horizontal, 10)
            }
            

        }
        .frame(height: 40)
        .background(Color.gray)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
            .font(.body.bold())
    }
}
