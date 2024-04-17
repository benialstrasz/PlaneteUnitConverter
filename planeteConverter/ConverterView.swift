//
//  ConverterView.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import SwiftUI
import SwiftData
import LaTeXSwiftUI

struct ConverterView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ConversionItem]
    
    @State private var valueToConvert = 1.0 {
        didSet {
            convertedValue = self.valueToConvert * selectedUnit2.value
        }
    }
    
    @State private var convertedValue = 1.0
    @State private var selectedPrefix1 = Prefix.none
    @State private var selectedUnit1 = Unit.Mearth {
        didSet {
            if (selectedUnit2.category != selectedUnit1.category) {
                selectedUnit2 = Unit.UnitsArray.filter({$0.category == selectedUnit1.category})[0]
            }
        }
    }
    @State private var selectedUnit2 = Unit.Mj
    
    var body: some View {
        List {
            HStack {
                TextField("Convert This", value: $valueToConvert, format: .number)
                    .padding(5)
                    .background(.background)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0))
                    )
                    .onSubmit {
                        updateValue()
                    }
                Menu {
                    Button(action: {
                        selectedPrefix1 = Prefix.none
                        updateValue()
                    }, label: {
                        Text("     ")
                    })

                    ForEach(Prefix.PrefixArray, id: \.id) { prefix in
                        Button(action: {
                            selectedPrefix1 = prefix
                            updateValue()
                        }, label: {
                            Text("\(prefix.abbreviation) (\(prefix.name))")
                        })
                    }
                } label: {
                    Text(selectedPrefix1.abbreviation)
                }

                Menu {
                    ForEach(Unit.UnitsArray.filter({$0.category != .other}), id: \.id) { unit in
                        Button(action: {
                            selectedUnit1 = unit
                            updateValue()
                        }, label: {
//                            LaTeX(unit.LaTeXunit ?? "")
                            Text("\(unit.abbreviation) (\(unit.name))")
                        })
                    }
                } label: {
                    Text(selectedUnit1.abbreviation)
                }
                
                Text(" = ")
                Text(convertedValue, format: .number.notation(.scientific).precision(.fractionLength(3)))
                Menu {
                    ForEach(Unit.UnitsArray.filter({$0.category == selectedUnit1.category}), id: \.name) { unit in
                        Button(action: {
                            selectedUnit2 = unit
                            updateValue()
                        }, label: {
                            Text("\(unit.abbreviation) (\(unit.name))")
                        })
                    }
                } label: {
                    Text(selectedUnit2.abbreviation)
                }
                
            }
            .padding(15)
            .background(.thinMaterial)
            .cornerRadius(7) /// make the background rounded
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.blue, lineWidth: 2)
            )
            .listRowSeparator(.hidden)
            
            Button(action: {
                addItem()
            }, label: {
                Text("Save conversion")
            })
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .centerModifier()
            
            if !items.isEmpty {
                Section(" ") {
                    ForEach(items) { item in
                        //                    Text("\(item.value1) \(item.unit1.abbreviation) = \(item.value2) \(item.unit2.abbreviation)")
                        LaTeX("\(item.value1) $\(item.prefix1.name) \(item.unit1.LaTeXunit!)$ = \(item.value2) $\(item.unit2.LaTeXunit!)$")
                            .centerModifier()
                            .swipeActions {
                                Button("delete") {
                                    modelContext.delete(item)
                                }
                                .tint(.red)
                            }
                    }
                }
            }
            
        }
        .onAppear(perform: {
            updateValue()
        })
    }
    
    func updateValue() {
        self.convertedValue = valueToConvert * selectedPrefix1.value * (selectedUnit1.value / selectedUnit2.value)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = ConversionItem(timestamp: Date(), value1: valueToConvert, prefix1: selectedPrefix1, unit1: selectedUnit1, value2: convertedValue, unit2: selectedUnit2)
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
    
//    func delete(_ indexSet: IndexSet) {
//        for i in indexSet {
//            let item = items[i]
//            modelContext.delete(item)
//        }
//    }
    
}

#Preview {
    ConverterView()
}
