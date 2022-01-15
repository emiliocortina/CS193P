//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 24/12/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
	@ObservedObject var game: EmojiMemoryGame
	
	var body: some View {
		AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
			CardView(card)
				.onTapGesture {
					game.choose(card)
				}
		}
		.padding(.horizontal)
		.foregroundColor(.red)
	}
}

struct CardView: View {
	private let card: EmojiMemoryGame.Card;
	
	init(_ card: EmojiMemoryGame.Card) {
		self.card = card
	}
	
	var body: some View {
		// GeometryReader always accepts all the space offered to it
		GeometryReader { geometry in
			ZStack {
				let shape = RoundedRectangle(cornerRadius: DrawingContents.cornerRadius)
				if !card.isMatched {
					if card.isFaceUp {
						// This returns a TupleView
						shape.fill().foregroundColor(.white)
						shape.strokeBorder(lineWidth: DrawingContents.lineWidth)
						Text(card.content).font(font(in: geometry.size))
						Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 60))
							.padding(5)
							.opacity(0.7)
					} else {
						shape.fill()
					}
				}
			}
		}
		.padding(4)
	}
	
	private func font (in size: CGSize) -> Font {
		Font.system(size: min(size.width, size.height) * DrawingContents.fontScaling)
	}
	
	// Creating constants
	private struct DrawingContents {
		static let cornerRadius: CGFloat = 25
		static let lineWidth: CGFloat = 4
		static let fontScaling: CGFloat = 0.7
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		EmojiMemoryGameView(game: game)
			.preferredColorScheme(.dark)
			.previewInterfaceOrientation(.portrait)
		EmojiMemoryGameView(game: game)
			.preferredColorScheme(.light)
	}
}
