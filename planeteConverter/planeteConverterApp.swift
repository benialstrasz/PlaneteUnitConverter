//
//  planeteConverterApp.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import SwiftUI
import SwiftData

@main
struct planeteConverterApp: App {
    // ENABLE FOR SwiftData
    // DOESNT WORK; CRASHES ON RUNTIME. PROBLEM SEEMS TO BE THE enum IN UNITS. But SHOULD BE FIXED BY APPLE IN BETA??
//    var sharedNotesModelContainer: ModelContainer = {
//        let schema = Schema([
//            NoteItem.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//        
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    var sharedConversionModelContainer: ModelContainer = {
        let schema = Schema([
            ConversionItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        // Main Window, not needed I think
        //        WindowGroup {
        //            ContentView()
        //        }
        //        .modelContainer(sharedModelContainer)
        MenuBarExtra {
            MainContentView()
//                .modelContainer(sharedNotesModelContainer)
                .modelContainer(sharedConversionModelContainer)
        } label: {
            Image("PC16")
//                .imageScale(.large)
        }
        .menuBarExtraStyle(.window)
//        .modelContainer(sharedNotesModelContainer) // ENABLE FOR SwiftData
        
    }
}
