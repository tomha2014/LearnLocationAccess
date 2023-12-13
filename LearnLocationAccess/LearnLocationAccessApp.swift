//
//  LearnLocationAccessApp.swift
//  LearnLocationAccess
//
//  Created by tom hackbarth on 12/11/23.
//

import SwiftUI

@main
struct LearnLocationAccessApp: App {
    
    @StateObject private var viewModel = UserLocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)   
        }
    }
}
