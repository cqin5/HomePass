//
//  HomePassApp.swift
//  HomePass
//
//  Created by Chuhan Qin on 2023-11-21.
//

import SwiftUI

@main
struct HomePassApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PassesListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
