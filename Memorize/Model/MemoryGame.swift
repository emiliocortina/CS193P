//
//  MemoryGame.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 27/12/21.
//

import Foundation

// This is the model
struct MemoryGame<T> where T: Equatable {
	// View Model has only read permissions on the 'cards' objects
	private(set) var cards: Array<Card>
	
	private var indexOfTheOneAndOnlyFaceUpCard: Int? {
		get {
			cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
		}
		set {
			cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
		}
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> T) {
		cards = []
		for i in 0..<numberOfPairsOfCards {
			let content = createCardContent(i)
			cards.append(Card(content: content, id: i*2))
			cards.append(Card(content: content, id: i*2+1))
		}
		cards.shuffle()
	}
	
	mutating func choose(_ card: Card) {
		// Unwrapping the optional
		if let cardIndex = cards.firstIndex(of: card),
		   !cards[cardIndex].isFaceUp,
		   !cards[cardIndex].isMatched {
			if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
				if cards[cardIndex].content == cards[potentialMatchIndex].content {
					// Correct guess
					cards[cardIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
				}
				cards[cardIndex].isFaceUp = true
			} else {
				indexOfTheOneAndOnlyFaceUpCard = cardIndex
			}
		}
	}
	
	mutating func shuffle() {
		cards.shuffle()
	}
	
	struct Card: Identifiable, Equatable  {
		var isFaceUp = false;
		var isMatched = false;
		let content: T;
		let id: Int
		
		// This i not needed because all of the structs variables are equatable so it is done automatically
//		static func == (lhs: MemoryGame<T>.Card, rhs: MemoryGame<T>.Card) -> Bool {
//			lhs.id == rhs.id &&
//			lhs.isFaceUp == rhs.isFaceUp &&
//			lhs.content == rhs.content &&
//			lhs.isMatched == rhs.isMatched
//		}
	}
}

extension Array {
	var oneAndOnly: Element? {
		if self.count == 1 {
			return self.first
		} else {
			return nil
		}
	}
}
