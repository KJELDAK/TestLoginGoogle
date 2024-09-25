//
//  TestLoginJomGoogleApp.swift
//  TestLoginJomGoogle
//
//  Created by MacBook Pro on 25/9/24.
//

import SwiftUI


@main
struct TestLoginApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserAuthModel()) // Inject UserAuthModel as an EnvironmentObject
        }
    }
}
