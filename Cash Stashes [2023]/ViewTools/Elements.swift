//
//  Elements.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/18/22.
//

import Foundation
import SwiftUI

func delay(_ delay: CGFloat, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: execute)
}

struct StashHeader: View {
    
    let text: String
    let list: [Item]
    
    @Binding var showTotal: Bool
    
    func sumList() -> Double {
        var sum: Double = 0
        for item in list {
            sum += item.amount
        }
        return sum
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .padding(20)
            Spacer()
            if sumList() > 0 {
                Button {
                    showTotal.toggle()
                } label: {
                    Text(sumList(), format: .currency(code: currency()))
                        .foregroundColor(.white)
                        .padding(5)
                        .padding(.horizontal, 8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.trailing, 20)
                }
            }
        }
        .padding(.top, 40)
    }
}

func gatherCash() -> [Item] {
    let array = CashList.loadFromFile()
    var output: [Item] = []
    if array.isEmpty { return [] } else {
        for i in array {
            output.append(Item(name: i.name, amount: i.amount, icon: i.icon))
        }
    }
    return output
}

func gatherCards() -> [Item] {
    let array = CardList.loadFromFile()
    var output: [Item] = []
    if array.isEmpty { return [] } else {
        for i in array {
            output.append(Item(name: i.name, amount: i.amount, icon: i.icon))
        }
    }
    return output
}

func gatherSavings() -> [Item] {
    let array = SavingsList.loadFromFile()
    var output: [Item] = []
    if array.isEmpty { return [] } else {
        for i in array {
            output.append(Item(name: i.name, amount: i.amount, icon: i.icon))
        }
    }
    return output
}

struct StashHeader_Previews: PreviewProvider {
    static var previews: some View {
        StashHeader(text: "Cash", list: [Item(name: "", amount: 8.53, icon: "")], showTotal: .constant(false))
            .background(Color("CashColor"))
    }
}


func currency() -> String {
    return Locale.current.currency?.identifier ?? "EUD"
}

struct StashAdd: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .padding(.horizontal, 20)
            .background(.white)
            .cornerRadius(40)
            .padding()
            .foregroundColor(.black)
    }
}

struct FieldLabel: View {
    let text: String
    var body: some View {
        Text("   \(text):")
            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            .foregroundColor(.gray)
            .padding(.top)
    }
}

struct Item: Hashable {
    var name: String
    var amount: Double
    var icon: String
}

struct GlowOverlay: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay (
                LinearGradient(colors: [.white.opacity(0.5), .clear], startPoint: .leading, endPoint: .trailing)
            )
    }
}

struct CashIconPicker: View {
    
    @Binding var selected: String
    let icons = ["dollarsign.circle.fill", "creditcard.circle.fill", "bitcoinsign.circle.fill", "chart.pie.fill", "centsign.circle.fill"]
    let color: Color
    
    var body: some View {
        Picker("", selection: $selected, content: {
            ForEach(icons, id: \.self, content: { icon in
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(color)
            })
        }) .padding()
            .pickerStyle(.segmented)
    }
}
