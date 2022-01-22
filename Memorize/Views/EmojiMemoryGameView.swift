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
		VStack {
			gameBody
			shuffle
		}
	}
	
	@State private var dealt = Set<Int>()
	
	private func deal(_ card: EmojiMemoryGame.Card) {
		dealt.insert(card.id)
	}
	
	private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
		!dealt.contains(card.id)
	}
	
	// TLDR: Transitions apply to the container view, animations propagate to children elements
	var gameBody: some View {
		AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
			// isUndealt(card) is used to put the view in screen after its container has appeared, so that it shows the insertion transition. WHY ISN'T THIS BUILT IN???? 😭
			if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
				Color.clear
			} else {
				CardView(card)
					.padding(4)
					.transition(AnyTransition.asymmetric(insertion: .scale, removal: SwiftUI.AnyTransition.opacity))
					.onTapGesture {
						withAnimation {
							game.choose(card)
						}
					}
			}
		}
		.onAppear {
			withAnimation {
				for card in game.cards {
					deal(card)
				}
			}
		}
		.foregroundColor(.red)
	}
	
	var shuffle: some View {
		Button("Shuffle") {
			// This animates the ViewModifiers 'position' and 'frame' of the CardViews being shuffled
			// This is an explicit animation, we almost always use them with intents
			withAnimation {
				game.shuffle()
			}
		}
		.padding()
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
					.animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: card.isMatched)
				//					.font(font(in: geometry.size))
				// This scaleEffect displays the emoji in low resolution.
					.scaleEffect(scale(thatFits: geometry.size))
			}
			.padding()
			.cardify(isFaceUp: card.isFaceUp)
		}
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
