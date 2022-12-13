//
//  Cash.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct Cash: View {
    var body: some View {
        NavigationStack {
            Text("Cash")
                .font(.largeTitle.bold())
        } .padding()
    }
}

struct Cash_Previews: PreviewProvider {
    static var previews: some View {
        Cash()
    }
}
