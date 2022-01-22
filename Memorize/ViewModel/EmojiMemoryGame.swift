//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 28/12/21.
//

import SwiftUI

// This is the View Model
class EmojiMemoryGame: ObservableObject {
	typealias Card = MemoryGame<String>.Card
	
	private static let emojis = ["🎉", "🤔", "🛢", "🥳", "🏎", "👀", "e", "a", "u", "o", "i", "d", "s"]
	private static let createEmojiMemoryGame = {
		MemoryGame<String>(
			numberOfPairsOfCards: 4,
			createCardContent: {(index: Int) -> String in
				emojis[index]
			})
	}
	
	// To make the model reactive, the View Model must implement ObservableObject and the model var
	// must be annotated with @Published
	@Published private var model = createEmojiMemoryGame()
	
	var cards: Array<Card> {
		return model.cards
	}
	
	// MARK: - Intent(s)
	
	func choose(_ card: Card) {
		model.choose(card)
	}
	
	func shuffle() {
		model.shuffle()
	}

}
