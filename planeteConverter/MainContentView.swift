//
//  MainContentView.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import SwiftUI
import SwiftData
import LaunchAtLogin
import Neumorphic

struct MainContentView: View {
    
    @StateObject var mVM = MainViewModel()
    
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [ConversionItem]

    var body: some View {
        VStack {
            if mVM.showNotes {
                SimpleNotesView()
//                    .modelContainer(sharedNotesModelContainer)
                    .frame(height: 300)
            } else {
                ConverterView()
            }
            Divider()
            HStack {
                Text("🪐 made by Beni")
                    .font(.caption2)
                
                Spacer()
                
//                Button {
//                    mVM.showNotes.toggle()
//                } label: {
//                    if mVM.showNotes {
//                        Text("Switch to converter")
//                    } else {
//                        Text("Switch to notes")
//                    }
//                }


                LaunchAtLogin.Toggle()
                
//                Button {
//                    //
//                } label: {
//                    Image(systemName: "gearshape.fill")
//                }

                Button {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Image(systemName: "power")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .keyboardShortcut("q")
            }
            .padding(.horizontal, 10)

        }
        .frame(width: 500)
        .padding(3)
        .background(
            Color.Neumorphic.main
        )
    }
    
}

#Preview {
    MainContentView()
}
