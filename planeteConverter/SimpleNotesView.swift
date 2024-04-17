//
//  SimpleNotesView.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import SwiftUI
import SwiftData

struct SimpleNotesView: View {
    @State var theNote = """

"""
    
    var body: some View {
        TextEditorView(string: $theNote)
    }
}

struct TextEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [NoteItem]

    @Binding var string: String {
        didSet {
            addItem()
        }
    }
    @State private var textEditorHeight : CGFloat = CGFloat()

    var body: some View {
        
        ZStack(alignment: .leading) {

            Text(items.isEmpty ? " " : items[0].text)
                .lineLimit(500)
                .foregroundColor(.clear)
                .padding(.top, 5.0)
                .padding(.bottom, 7.0)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            
            TextEditor(text: $string)
                .frame(height: textEditorHeight)
               
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
        .task {
            string = items.isEmpty ? " " : items[0].text
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = NoteItem(timestamp: Date(), text: string)
            // just replace the signle item with the new one (delete and readd)
            if !items.isEmpty {
                modelContext.delete(items[0])
            }
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}


#Preview {
    SimpleNotesView()
}
