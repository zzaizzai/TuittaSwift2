//
//  CommentRowView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/28.
//

import SwiftUI
import Firebase

class CommentRowViewModel: ObservableObject {
    
    @Published var comment: Comment?
    
    init(comment: Comment?){
        self.comment = comment
    }
}

struct CommentRowView: View {
    
    @ObservedObject var vm : CommentRowViewModel
    
    init(comment: Comment?){
        self.vm = CommentRowViewModel(comment: comment)
        
        
    }
    
    var body: some View {
        VStack {
//            Divider()
            
            HStack(alignment: .top) {
                ProfileImageView(user: vm.comment?.user ?? nil)
                VStack(alignment: .leading) {
                    Text(vm.comment?.user?.name ?? "name")
                    Text(vm.comment?.user?.email ?? "email")
                    Text(vm.comment?.commentText ?? "text")
                    
                }
                Spacer()
                
               
            }
            .padding(.horizontal)
            
//            Divider()
        }
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: nil)
    }
}
