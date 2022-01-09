//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 24/12/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
	let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
			ContentView(viewModel: game)
        }
    }
}
