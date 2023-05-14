//
//  LearnSwiftUIApp.swift
//  LearnSwiftUI
//
//  Created by Beket Muratbek on 25.11.2022.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    @StateObject private var flights = FlightsViewModel()
    var body: some Scene {
        WindowGroup {
            ParentView().environmentObject(flights)
        }
    }
}
