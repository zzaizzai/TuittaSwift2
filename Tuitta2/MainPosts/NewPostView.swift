//
//  NewPostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

class NewPostViewModel : ObservableObject {
    
    @Published var uploadText = "11"
}


struct NewPostView: View {
    
    @FocusState var focusState
    
    @ObservedObject var vm = NewPostViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    @State private var uploadImage : UIImage?
    @State private var showImagePicker = false
    
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
                        //                            .frame(height: )
                            .focused($focusState)
                        
                        
                        if let uploadImage = uploadImage {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uploadImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(20)
                                
                                Button {
                                    self.uploadImage = nil
                                } label: {
                                    Text("X")
                                        .zIndex(1)
                                        .frame(width: 30, height: 30)
                                        .background(Color.white)
                                        .cornerRadius(100)
                                }
                            }
                        } else {
                            Button {
                                showImagePicker = true
                            } label: {
                                Text("+photo")
                                    .foregroundColor(Color.black)
                                    .cornerRadius(20)
                            }
                        }
                        
                    }
                    
                }
                .padding(.horizontal, 5)
                
            }
            .fullScreenCover(isPresented: $showImagePicker, content: {
                ImagePicker(selectedImage: $uploadImage)
            })
            .onTapGesture {
                self.focusState = true
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
