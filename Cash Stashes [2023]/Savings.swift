//
//  Savings.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct Savings: View {
    
    // showSheet.0 = animation p1, showSheet.1 = animation p2, showSheet.2 = action
    @State var showSheet: (Bool, Bool, Bool) = (false, false, false)
    @State private var showTotal: Bool = false
    
    // showAdd.0 = animation p1, showAdd.1 = animation p2, showAdd.2 = action
    @State var showAdd: (Bool, Bool, Bool) = (false, false, false)
    
    @State var savingsList: [Item] = gatherSavings()
    @State var selection: Int = 0
    
    var body: some View {
        ZStack {
            Color("SavingsColor")
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StashHeader(text: "Savings", list: savingsList, showTotal: $showTotal)
                ForEach(savingsList.indices, id: \.self, content: { index in
                    let item = savingsList[index]
                    HStack {
                        Image(systemName: item.icon)
                            .resizable()
                            .foregroundColor(Color("SavingsColor"))
                            .frame(width: 25, height: 25)
                            .padding(.vertical, -5)
                        Text(item.name)
                            .foregroundColor(.black)
                        Spacer()
                        Text(item.amount, format: .currency(code: currency()))
                            .foregroundColor(.black)
                    } .padding()
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .onTapGesture {
                            selection = index
                            withAnimation { showSheet.0 = true }
                            withAnimation(.easeIn.delay(0.4), { showSheet.1 = true })
                            delay(1, execute: { showSheet.2 = true })
                        }
                        .offset(x: (selection == index && showSheet.0 == true) ? 10 : 0)
                        .offset(x: (selection == index && showSheet.1 == true) ? -500 : 0)
                    
                })
            } .overlay(alignment: .bottom, content: {
                Button {
                    withAnimation { showAdd.0 = true }
                    withAnimation(.easeIn.delay(0.4), { showAdd.1 = true })
                    delay(1, execute: { showAdd.2 = true })
                } label: {
                    StashAdd(text: "Add Item")
                        .offset(y: showAdd.0 ? -15 : 0)
                        .offset(y: showAdd.1 ? 150 : 0)
                }
            })
            .sheet(isPresented: $showSheet.2, onDismiss: {
                withAnimation {
                    showSheet = (false, false, false)
                }
            }, content: {
                EditItem(showSheet: $showSheet, item: $savingsList[selection], color: Color("SavingsColor"))
            })
            .sheet(isPresented: $showAdd.2, onDismiss: {
                withAnimation {
                    showAdd = (false, false, false)
                }
            }, content: {
                AddItem(showSheet: $showAdd, list: $savingsList, color: Color("SavingsColor"))
            })
            .onChange(of: savingsList, perform: { _ in
                let array = savingsList
                var output: [SavingsList] = []
                if array.isEmpty { SavingsList.saveToFile([]) } else {
                    for i in array {
                        output.append(SavingsList(name: i.name, amount: i.amount, icon: i.icon))
                    }
                    SavingsList.saveToFile(output)
                }
            })
        }
    }
}

struct Savings_Previews: PreviewProvider {
    static var previews: some View {
        Savings()
    }
}
