//
//  UserRowView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/28.
//

import SwiftUI

class UserRowViewModel: ObservableObject {
    @Published var user : User?
    
    init(user: User?){
        self.user = user
        
    }
}

struct UserRowView: View {
    
    @ObservedObject var vm : UserRowViewModel
    
    init(user: User?){
        self.vm = UserRowViewModel(user: user)
        
    }
    
    var body: some View {
        HStack(alignment: .top){
            
            ProfileImageView(user: vm.user)
            
            VStack(alignment: .leading) {
                Text(vm.user?.name ?? "name")
                Text(vm.user?.email ?? "email")
                Text("profiletext")
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: nil)
    }
}
