////
//  Tuitta2App.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//
//
import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct Tuitta2App: App {
    @StateObject var vmAuth = AuthViewModel()
    @StateObject var page = PageControl()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            MainTabView2()
                .environmentObject(PageControl())
                .environmentObject(AuthViewModel())
                .font(.body.bold())
        }
    }
}
