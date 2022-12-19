//
//  AddItem.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/18/22.
//

import SwiftUI

struct AddItem: View {
    
    @Binding var showSheet: (Bool, Bool, Bool)
    @Binding var list: [Item]
    let color: Color
    
    @State var name: String = ""
    @State var amount: Double? = nil
    @State var icon: String = "dollarsign.circle.fill"
    
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader {
                let size = $0.size
                ScrollView {
                    Text("Add Item")
                        .frame(width: size.width, height: 50)
                        .background(.regularMaterial)
                        .bold()
                    FieldLabel(text: "Icon")
                    CashIconPicker(selected: $icon, color: color)
                    FieldLabel(text: "Name")
                    TextField("Stash o' Cash", text: $name)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($showKeyboard)
                    FieldLabel(text: "Amount")
                    TextField("0.00", value: $amount, format: .currency(code: currency()))
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)
                        .focused($showKeyboard)
                    Button {
                        list.append(Item(name: name == "" ? "Stash o' Cash" : name, amount: amount ?? 0, icon: icon))
                        showSheet = (false, false, false)
                    } label: {
                        Text("Add")
                            .padding()
                            .padding(.horizontal, 30)
                            .background(.regularMaterial)
                            .cornerRadius(25)
                            .padding()
                            .foregroundColor(color)
                    }
                } .toolbar(content: {
                    ToolbarItem(placement: .keyboard, content: {
                        HStack {
                            Button {
                                showKeyboard.toggle()
                            } label: {
                                Text("Done")
                                    .padding(.trailing)
                                    .foregroundColor(color)
                            }
                        } .frame(width: size.width, alignment: .trailing)
                    })
                })
            }
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(showSheet: .constant((false, false, false)), list: .constant([]), color: Color("CashColor"))
    }
}
