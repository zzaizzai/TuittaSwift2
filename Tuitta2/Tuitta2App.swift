//
//  Tuitta2App.swift
//  Tuitta2
//
//  Created by 小暮準才 on 2022/08/20.
//

import SwiftUI

@main
struct Tuitta2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PageControl())
                .environmentObject(AuthViewModel())
                .font(.body.bold())
        }
    }
}
