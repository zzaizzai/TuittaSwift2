//
//  EnvironView.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import Foundation

class PageControl : ObservableObject {
    
    @Published var tabIndex = 0
    
    @Published var showSideMenu = false
    
    
    //index 0
    @Published var showDetailIndex0 = false
    @Published var showUserProfileIndex0 = false
    @Published var showMyProfileIndex0 = false
    @Published var countIndex0 = 0
    
    @Published var showMyProfileIndex3 = false
    
    
    
    //
    
    func resetPage(index : Int) {
        if index == 0{
            if self.showDetailIndex0 || self.showUserProfileIndex0 || self.showMyProfileIndex0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.countIndex0 += 1
                }
            } else {
                self.countIndex0 += 1
            }
            
            self.showDetailIndex0 = false
            self.showUserProfileIndex0 = false
            self.showMyProfileIndex0 = false
            

        }
        if index == 1 {
            
        }
        
        if index == 3 {
            self.showMyProfileIndex3 = false
        }
    }
    
    
    
}
