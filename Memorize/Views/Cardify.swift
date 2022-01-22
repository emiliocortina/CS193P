//
//  Cardify.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 21/1/22.
//

import SwiftUI

struct Cardify: ViewModifier {
	var isFaceUp: Bool
	
	func body(content: Content) -> some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
			if isFaceUp {
				// This returns a TupleView
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
			} else {
				
				shape.fill()
			}
			// Content has to be on the view for the animation to happen, so instead of rendering only when the card is face up, we change its opacity
			content.opacity(isFaceUp ? 1 : 0)
		}
	}
	
	// Creating constants
	private struct DrawingConstants {
		static let cornerRadius: CGFloat = 25
		static let lineWidth: CGFloat = 4
	}
}

extension View {
	func cardify(isFaceUp: Bool) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp))
	}
}
