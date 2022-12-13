//
//  Card.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct Card: View {
    var body: some View {
        NavigationStack {
            Color("CardColor")
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("Card")
        } .padding()
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card()
    }
}
