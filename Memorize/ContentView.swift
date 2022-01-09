//
//  ContentView.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 24/12/21.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel: EmojiMemoryGame
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
				ForEach(viewModel.cards) {card in
					CardView(card: card).onTapGesture {
						viewModel.choose(card)
					}
				}
			}
			.padding(.horizontal)
			.foregroundColor(.red)
		}
	}
}

struct CardView: View {
	let card: MemoryGame<String>.Card;
	
	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 25)
			if !card.isMatched {
				if card.isFaceUp{
					// This returns a TupleView
					shape.fill().foregroundColor(.white)
					shape.strokeBorder(lineWidth: 4)
					Text(card.content)
						.font(.largeTitle)
				} else {
					shape.fill()
				}
			}
			
		}
		.aspectRatio(2/3, contentMode: ContentMode.fit)
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		ContentView(viewModel: game)
			.preferredColorScheme(.dark)
			.previewInterfaceOrientation(.portrait)
		ContentView(viewModel: game)
			.preferredColorScheme(.light)
	}
}

