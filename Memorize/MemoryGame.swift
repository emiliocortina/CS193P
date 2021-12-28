//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 27/12/21.
//

import Foundation

// This is the model
struct MemoryGame<T> {
	// View Model has only read permissions on the 'cards' objects
	private(set) var cards: Array<Card>
	
	func choose(_ card: Card) {
		
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> T) {
		cards = Array<Card>()
		for i in 0..<numberOfPairsOfCards {
			let content: T = createCardContent(i)
			cards.append(Card(content: content))
			cards.append(Card(content: content))
		}
	}
	
	struct Card  {
		var isFaceUp: Bool = false;
		var isMatched: Bool = false;
		var content: T;
	}
}
