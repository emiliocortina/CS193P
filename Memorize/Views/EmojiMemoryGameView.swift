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
				// Animations can only happen in two ways, Shapes or ViewModifiers
				Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 60))
					.padding(5)
					.opacity(0.7)
				Text(card.content)
					// The only time the ViewModifiers can be animated is when they change, so if the arguments passed to a ViewModifier don't change the animation can't happen.
					// This implicit animation will fire whenever the card.isMatched value changes
					.rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
					.animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
//					.font(font(in: geometry.size))
					// This scaleEffect displays the emoji in low resolution.
					.scaleEffect(scale(thatFits: geometry.size))
			}
			.cardify(isFaceUp: card.isFaceUp)
		}
		.padding(4)
		
	}
	
	private func scale(thatFits size: CGSize) -> CGFloat {
		min(size.width, size.height) / DrawingConstants.fontSize / DrawingConstants.fontScaling
	}
	
	
	// This causes weird glitches with animations when the display is rotated deprecated in favor of .scaleEffect(scale(thatFits: geometry.size))
		private func font (in size: CGSize) -> Font {
			Font.system(size: min(size.width, size.height) * DrawingConstants.fontScaling)
		}
	
	// Creating constants
	private struct DrawingConstants {
		static let fontScaling: CGFloat = 0.7
		static let fontSize: CGFloat = 32
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
