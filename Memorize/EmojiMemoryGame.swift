//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 28/12/21.
//

import SwiftUI

// This is the View Model
class EmojiMemoryGame {
	static let emojis = ["🎉", "🤔", "🛢", "🥳", "🏎", "👀", "e", "a", "u", "o", "i", "d", "s"]
	static let createEmojiMemoryGame = {
		MemoryGame<String>(
			numberOfPairsOfCards: 4,
			createCardContent: {(index: Int) -> String in
				emojis[index]
			})
	}
	private var model: MemoryGame<String> = createEmojiMemoryGame()
	
	var cards: Array<MemoryGame<String>.Card> {
		return model.cards
	}
}
