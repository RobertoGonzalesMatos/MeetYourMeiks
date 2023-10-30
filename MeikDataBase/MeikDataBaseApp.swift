//
//  MeikDataBaseApp.swift
//  MeikDataBase
//
//  Created by Roberto Gonzales on 8/28/23.
//
import FirebaseCore
import SwiftUI

@main
struct MeikDataBaseApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
