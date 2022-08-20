//
//  RecentMessagesView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

struct RecentMessagesView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("recentMessages view")
                
                NavigationLink {
                    Text("go 11")
                } label: {
                    Text("gogog")
                }
                
            }
        }
        .navigationTitle("title")
    }
}

struct RecentMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMessagesView()
    }
}
