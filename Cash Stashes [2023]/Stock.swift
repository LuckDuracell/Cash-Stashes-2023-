//
//  Stock.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct Stock: View {
    var body: some View {
        NavigationStack {
            Color("StockColor")
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("Stock")
        } .padding()
    }
}

struct Stock_Previews: PreviewProvider {
    static var previews: some View {
        Stock()
    }
}
