//
//  EditItem.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/18/22.
//

import SwiftUI

struct EditItem: View {
    
    @Binding var showSheet: (Bool, Bool, Bool)
    @Binding var item: Item
    let color: Color
    
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader {
                let size = $0.size
                ScrollView {
                    Text("Edit Item")
                        .frame(width: size.width, height: 50)
                        .background(.regularMaterial)
                        .bold()
                    FieldLabel(text: "Icon")
                    CashIconPicker(selected: $item.icon, color: color)
                    FieldLabel(text: "Name")
                    TextField("Stash o' Cash", text: $item.name)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .focused($showKeyboard)
                    FieldLabel(text: "Amount")
                    TextField("0.00", value: $item.amount, format: .currency(code: currency()))
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)
                        .focused($showKeyboard)
                    Button {
                        item.amount = -9.95818
                        showSheet = (false, false, false)
                    } label: {
                        Text("Delete")
                            .foregroundColor(.red)
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

struct EditItem_Previews: PreviewProvider {
    static var previews: some View {
        EditItem(showSheet: .constant((false, false, false)), item: .constant(Item(name: "Testing", amount: 9.99, icon: "dollarsign.circle.fill")), color: Color("CashColor"))
    }
}
