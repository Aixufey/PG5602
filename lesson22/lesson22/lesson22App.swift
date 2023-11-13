//
//  lesson22App.swift
//  lesson22
//
//  Created by Jack Xia on 07/11/2023.
//

import SwiftUI

@main
struct lesson22App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
