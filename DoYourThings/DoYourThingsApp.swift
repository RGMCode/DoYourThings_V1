//
//  DoYourThingsApp.swift
//  DoYourThings
//
//  Created by RGMCode on 26.05.24.
//

import SwiftUI

@main
struct DoYourThingsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DoYourThingsViewModel())
        }
    }
}
