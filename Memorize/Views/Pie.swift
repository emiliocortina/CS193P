//
//  Pie.swift
//  Memorize
//
//  Created by Cortina Labra, Emilio on 15/1/22.
//

import SwiftUI

struct Pie: Shape {
	// The angles need to be var because they're going to be animated
	var startAngle: Angle
	var endAngle: Angle
	// This needs to be a var because it wouldn't otherwise be customizable
	// The origin 0,0 is at the top left
	var clockWise = false
	
	func path(in rect: CGRect) -> Path {
		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2
		let start = CGPoint(
			x: center.x + radius * CGFloat(cos(startAngle.radians)),
			y: center.y + radius * CGFloat(sin(startAngle.radians)))
		var p = Path()
		p.move(to: center)
		p.addLine(to: start)
		p.addArc(center: center,
				 radius: radius,
				 startAngle: startAngle,
				 endAngle: endAngle,
				 clockwise: !clockWise
		)
		p.addLine(to: center)
		return p
	}
}
