//
//  Cash.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct Cash: View {
    
    // showSheet.0 = animation p1, showSheet.1 = animation p2, showSheet.2 = action
    @State var showSheet: (Bool, Bool, Bool) = (false, false, false)
    @State private var showTotal: Bool = false
    
    // showAdd.0 = animation p1, showAdd.1 = animation p2, showAdd.2 = action
    @State var showAdd: (Bool, Bool, Bool) = (false, false, false)
    
    @State var cashList: [Item] = gatherCash()
    @State var selection: Int = 0
    
    func saveCashlist() {
        let array = cashList
        var output: [CashList] = []
        if array.isEmpty { CashList.saveToFile([]) } else {
            for i in array {
                output.append(CashList(name: i.name, amount: i.amount, icon: i.icon))
            }
            CashList.saveToFile(output)
        }
    }
    
    var body: some View {
        ZStack {
            Color("CashColor")
                .edgesIgnoringSafeArea(.all)
                .modifier(GlowOverlay())
            ScrollView {
                StashHeader(text: "Cash", list: cashList, showTotal: $showTotal)
                ForEach(cashList.indices, id: \.self, content: { index in
                    let item = cashList[index]
                    HStack {
                        Image(systemName: item.icon)
                            .resizable()
                            .foregroundColor(Color("CashColor"))
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
                var removed = 0
                for i in cashList.indices {
                    if cashList[i - removed].amount == -9.95818 {
                        withAnimation {
                            cashList.remove(at: i - removed)
                        }
                        removed += 1
                    }
                }
                withAnimation {
                    showSheet = (false, false, false)
                }
            }, content: {
                EditItem(showSheet: $showSheet, item: $cashList[selection], color: Color("CashColor"))
            })
            .sheet(isPresented: $showAdd.2, onDismiss: {
                withAnimation {
                    showAdd = (false, false, false)
                }
            }, content: {
                AddItem(showSheet: $showAdd, list: $cashList, color: Color("CashColor"))
            })
            .onChange(of: cashList, perform: { _ in
                saveCashlist()
            })
        }
    }
}

struct Cash_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





