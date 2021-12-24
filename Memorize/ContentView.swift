//
//  ContentView.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 24/12/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        ZStack {
            // This returns a TupleView
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 4)
            Text("HOLAAAAAAA")
        }
        .padding(.horizontal)
        .foregroundColor(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
