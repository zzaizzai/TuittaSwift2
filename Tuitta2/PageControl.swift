//
//  EnvironView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import Foundation

class PageControl : ObservableObject {
    //PostPage
    @Published var showPostIndex0 = false
    @Published var count1 = 0
    
    
    //
    
    func resetPage(index : Int) {
        if index == 0{
            self.showPostIndex0 = false
        }
        if index == 1 {
            
        }
    }
    
    
    func resetAllPages() {
        self.showPostIndex0 = false
    }
    
}
