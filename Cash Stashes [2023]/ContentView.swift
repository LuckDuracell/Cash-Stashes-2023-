//
//  ContentView.swift
//  Cash Stashes [2023]
//
//  Created by Luke Drushell on 12/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                Cash()
                Card()
                Savings()
            } .tabViewStyle(.page)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
