//
//  Pie.swift
//  Memorize
//
//  Created by Victor Tatai on 5/23/21.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var p = Path()
        p.move(to: center)
        p.addLine(to: calcCircleCoords(from: center, angle: startAngle, radius: radius))
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        p.addLine(to: center)
        return p
    }
    
    private func calcCircleCoords(from: CGPoint, angle: Angle, radius: CGFloat) -> CGPoint {
        CGPoint (
            x: from.x + radius * cos(CGFloat(startAngle.radians)),
            y: from.y + radius * sin(CGFloat(startAngle.radians))
        )
    }
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -180)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}
