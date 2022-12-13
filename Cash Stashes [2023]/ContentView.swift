//
//  ContentView.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                Cash()
                    .background(Color("CashColor"))
                Card()
                    .background(Color("CardColor"))
                Stock()
                    .background(Color("StockColor"))
            } .tabViewStyle(.page)
        } .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
