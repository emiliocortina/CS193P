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
	
	var indexOfTheOneAndOnlyFaceUpCard: Int?
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> T) {
		cards = Array<Card>()
		for i in 0..<numberOfPairsOfCards {
			let content: T = createCardContent(i)
			cards.append(Card(content: content, id: i*2))
			cards.append(Card(content: content, id: i*2+1))
		}
	}
	
	mutating func choose(_ card: Card) {
		// Unwrapping the optional
		if let cardIndex = cards.firstIndex(of: card),
		   !cards[cardIndex].isFaceUp,
		   !cards[cardIndex].isMatched {
			if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
				potentialMatch(cardIndex: cardIndex, potentialMatchIndex: potentialMatchIndex)
			} else {
				for i in cards.indices {
					cards[i].isFaceUp = false
				}
				indexOfTheOneAndOnlyFaceUpCard = cardIndex
			}
			cards[cardIndex].isFaceUp.toggle()
		}
	}
	
	mutating func potentialMatch(cardIndex: Int, potentialMatchIndex: Int) {
		if cards[cardIndex].content == cards[potentialMatchIndex].content &&
			cards[cardIndex] != cards[potentialMatchIndex]{
			// Correct guess
			cards[cardIndex].isMatched = true
			cards[potentialMatchIndex].isMatched = true
		} else {
			// Wrong guess
			for i in cards.indices {
				cards[i].isFaceUp = false
			}
			cards[cardIndex].isMatched = false
			cards[potentialMatchIndex].isMatched = false
		}
		indexOfTheOneAndOnlyFaceUpCard = nil
	}
	
	struct Card: Identifiable, Equatable  {
		var isFaceUp: Bool = false;
		var isMatched: Bool = false;
		var content: T;
		var id: Int
		
		static func == (lhs: MemoryGame<T>.Card, rhs: MemoryGame<T>.Card) -> Bool {
			lhs.id == rhs.id &&
			lhs.isFaceUp == rhs.isFaceUp &&
			lhs.content == rhs.content &&
			lhs.isMatched == rhs.isMatched
		}
	}
}
