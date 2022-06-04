//
//  Event_Management_SystemApp.swift
//  Event-Management-System
//
//  Created by Leng Mouyngech on 4/6/22.
//

import SwiftUI

@main
struct Event_Management_SystemApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
