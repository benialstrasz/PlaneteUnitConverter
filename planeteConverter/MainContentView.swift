//
//  MainContentView.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import SwiftUI
import SwiftData
import LaunchAtLogin

struct MainContentView: View {
    
    @StateObject var mVM = MainViewModel()
    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [ConversionItem]

    var body: some View {
        VStack(spacing: 0) {
            Group {
                if mVM.showNotes {
                    SimpleNotesView()
                        .frame(height: 300)
                } else {
                    ConverterView()
                }
            }
            .frame(minHeight: 300)
//            .padding(8)
//            .glassSurface(cornerRadius: 22, material: .ultraThinMaterial)

            Divider()
                .padding(.horizontal, 10)

            HStack {
                Text("🪐 made by Beni")
                    .font(.caption2)
                Text("(v" + currentVersion + ")")
                    .font(.caption2)
                    .fontWeight(.ultraLight)

                Spacer()

                LaunchAtLogin.Toggle()

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
            .padding(.vertical, 8)
        }
        .frame(width: 500)
        .padding(10)
        .background {
            Rectangle().fill(.ultraThinMaterial)
                .overlay(DS.baseGradient)
        }
    }
    
}

#Preview {
    MainContentView()
}
