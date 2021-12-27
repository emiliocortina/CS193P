//
//  ContentView.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 24/12/21.
//

import SwiftUI

struct ContentView: View {
	var emojis = ["🎉", "🤔", "🛢", "🥳", "🏎", "👀", "e", "a", "u", "o", "i", "d", "s"]
	@State var emojiCount = 2
	
	var body: some View {
		ZStack {
			ScrollView {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
					ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
						CardView(content: emoji)
						
					})
				}
				.padding(.horizontal)
				.foregroundColor(.red)
			}
			VStack {
				Spacer()
				HStack {
					remove
					Spacer()
					add
				}
			}.padding(.all)
			
		}
	}
	
	var remove: some View {
		Button(action: {
			if(emojiCount>1) {
				emojiCount -= 1
			}
		}, label: {Image(systemName: "minus.circle")})
			.padding().font(.largeTitle)
			.background(.regularMaterial, in: RoundedRectangle(cornerRadius: .greatestFiniteMagnitude))
	}
	
	var add: some View {
		Button(action: {
			if(emojiCount<emojis.count){
				emojiCount += 1
			}
		}, label: { Image(systemName: "plus.circle")})
			.padding().font(.largeTitle)
			.background(.regularMaterial, in: RoundedRectangle(cornerRadius: .greatestFiniteMagnitude))
	}
}

struct CardView: View {
	@State var isFaceUp: Bool = false
	var content: String
	
	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 25)
			if isFaceUp{
				// This returns a TupleView
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: 4)
				Text(content)
					.font(.largeTitle)
			} else {
				shape.fill()
			}
		}
		.aspectRatio(2/3, contentMode: ContentMode.fit)
		.onTapGesture(perform: {
			isFaceUp = !isFaceUp
		})
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.preferredColorScheme(.dark)
			.previewInterfaceOrientation(.portrait)
		ContentView()
			.preferredColorScheme(.light)
	}
}
