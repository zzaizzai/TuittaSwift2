//
//  NewPostView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

class NewPostViewModel : ObservableObject {
    
    @Published var uploadText = ""
    @Published var uploadImage : UIImage?
    @Published var errorMessage = "error"
    
    
    
    func uplaodNewPost(done: @escaping(Bool)->()) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        
        let ref = Firestore.firestore().collection("posts").document()

        let docId = ref.documentID
//
            let data = [

                "authorUid" : user.uid,
                "postText" : self.uploadText,
                "postImageUrl": "",
                "time" : Date(),
            ] as [String:Any]
        
        
        ref.setData(data) { error in
            if let error = error {
                print(error)
                return
            }
            
            self.errorMessage = "\(docId)"
            
            self.storePostImage(docId: docId) { url in
                if url == "" {
                    self.errorMessage = "upload done with image"
                    done(true)
                    
                } else {
                    
                    
                    Firestore.firestore().collection("posts").document(docId).setData(["postImageUrl" : url ], merge: true) { error in
                        if let error = error {
                            print(error)
                            return
                        }
                        self.errorMessage = "upload done without image"
                        
                        self.uploadText = ""
                        self.uploadImage = nil
                        done(true)
                    }
                }
            }
            
            
        }
        
    }
    func storePostImage (docId: String, done: @escaping(String)->()) {
        guard let _ = self.uploadImage else {
            done("")
            return }
        
        let ref = Storage.storage().reference(withPath: "posts/" + docId )
        guard let imageData = self.uploadImage?.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print(error)
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let postImageUrl = url?.absoluteString else { return }
                
                done(postImageUrl)
                
            }
        }
        
        
    }
}


struct NewPostView: View {
    
    @FocusState var focusState
    
    @ObservedObject var vm = NewPostViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    @State private var showImagePicker = false
    
    var body: some View {
        VStack{
            Text(vm.errorMessage)
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
                        
                        
                        if let uploadImage = vm.uploadImage {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uploadImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(20)
                                
                                Button {
                                    vm.uploadImage = nil
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
                ImagePicker(selectedImage: $vm.uploadImage)
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
                    vm.uplaodNewPost { done in
                        if done {
                            dismiss()
                        }
                    }
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
