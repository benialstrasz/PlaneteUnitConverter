//
//  ConverterView.swift
//  planeteConverter
//
//  Created by Benedikt Gottstein on 16.04.2024.
//

import SwiftUI
import SwiftData
import LaTeXSwiftUI
import Neumorphic

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
                ZStack {
                    TextField("Convert This", value: $valueToConvert, format: .number)
                        .padding()
                        .onChange(of: valueToConvert) { oldValue, newValue in
                            updateValue()
                        }
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color.Neumorphic.main)
                        .softOuterShadow()
                        .frame(height:35)
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
                    ForEach(Unit.Category.allCases) { cate in
                        Section("\(cate.id)") {
                            ForEach(Unit.UnitsArray.filter({ ($0.category == cate) && ($0.category != .other)}), id: \.id) { unit in
                                Button(action: {
                                    selectedUnit1 = unit
                                    updateValue()
                                }, label: {
                                    //                            LaTeX(unit.LaTeXunit ?? "")
                                    Text("\(unit.abbreviation) (\(unit.name))")
                                })
                            }
                        }
                    }
                } label: {
                    Text(selectedUnit1.abbreviation)
                }
                
                Text(" = ")
                Text(convertedValue, format: .number.notation(.scientific).precision(.fractionLength(3)))
                    .bold()
                    .font(.headline)
                    .contextMenu(menuItems: {
                        Button {
                            let pasteboard = NSPasteboard.general
                            pasteboard.declareTypes([.string], owner: nil)
                            pasteboard.setString(String(convertedValue), forType: .string)
                        } label: {
                            Text("Copy value")
                        }
                    })
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
                
                Button(action: {
                    addItem()
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .softButtonStyle(Circle(), padding: 10, textColor: .green, pressedEffect: .hard)
            }
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow()
            )
            .listRowSeparator(.hidden)
            .padding(.vertical)
            //            .padding(.bottom, 5)
                        
            if !items.isEmpty {
                Section("Saved conversions") {
                    ForEach(items) { item in
                        let scientificValue2 = String(item.value2.formatted(.number.notation(.scientific).precision(.fractionLength(3))))
                        
                        LaTeX("\(item.value1) \\, \\mathrm{\(item.prefix1.abbreviation)} \(item.unit1.LaTeXunit!) = \(scientificValue2) \\, \\, \(item.unit2.LaTeXunit!)")
                            .parsingMode(.all)
                            .centerModifier()
                            .swipeActions {
                                Button("delete") {
                                    modelContext.delete(item)
                                }
                                .tint(.red)
                            }
                            .contextMenu(menuItems: {
                                Button {
                                    let pasteboard = NSPasteboard.general
                                    pasteboard.declareTypes([.string], owner: nil)
                                    pasteboard.setString(String(item.value2), forType: .string)
                                } label: {
                                    Text("Copy value")
                                }
                            })

                    }
                }
            }
            
        }
//        .listRowSeparator(.hidden)
        .background(Color.Neumorphic.main)
        //        .scrollContentBackground(.hidden)
        .onAppear(perform: {
            updateValue()
        })
    }
    
    func updateValue() {
        // First, check if the selected units have custom conversion logic
        if let conversionFunction = selectedUnit1.conversionFunction {
            // Use the custom conversion function for non-linear conversions
            self.convertedValue = conversionFunction(valueToConvert * selectedPrefix1.value, selectedUnit2)
        } else if let conversionFunction = selectedUnit2.conversionFunction {
            // In case the target unit has a conversion logic from SI unit
            self.convertedValue = conversionFunction(valueToConvert * selectedPrefix1.value / selectedUnit1.value, selectedUnit2)
        } else {
            // Default linear conversion for other units
            self.convertedValue = valueToConvert * selectedPrefix1.value * (selectedUnit1.value / selectedUnit2.value)
        }
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
