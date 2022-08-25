//
//  Created by Anton Heestand on 2022-08-25.
//

import CoreGraphics
import SwiftUI

extension RoundedCorner {
    
    /// https://stackoverflow.com/a/24780108
    static func create(at angularPoint: CGPoint, from p1: CGPoint, to p2: CGPoint, radius: CGFloat) -> RoundedCorner {
        
        var radius: CGFloat = radius
        
        //Vector 1
        let dx1: CGFloat = angularPoint.x - p1.x
        let dy1: CGFloat = angularPoint.y - p1.y
        
        //Vector 2
        let dx2: CGFloat = angularPoint.x - p2.x
        let dy2: CGFloat = angularPoint.y - p2.y
        
        //Angle between vector 1 and vector 2 divided by 2
        let angle: CGFloat = (atan2(dy1, dx1) - atan2(dy2, dx2)) / 2
        
        // The length of segment between angular point and the
        // points of intersection with the circle of a given radius
        let tan: CGFloat = abs(tan(angle))
        var segment: CGFloat = radius / tan
        
        //Check the segment
        let length1: CGFloat = getLength(dx1, dy1)
        let length2: CGFloat = getLength(dx2, dy2)
        
        let length: CGFloat = min(length1, length2)
        
        if segment > length {
            segment = length
            radius = length * tan
        }
        
        // Points of intersection are calculated by the proportion between
        // the coordinates of the vector, length of vector and the length of the segment.
        var p1Cross = getProportionPoint(angularPoint, segment, length1, dx1, dy1)
        var p2Cross = getProportionPoint(angularPoint, segment, length2, dx2, dy2)
        
        // Calculation of the coordinates of the circle
        // center by the addition of angular vectors.
        let dx: CGFloat = angularPoint.x * 2 - p1Cross.x - p2Cross.x
        let dy: CGFloat = angularPoint.y * 2 - p1Cross.y - p2Cross.y
        
        let L: CGFloat = getLength(dx, dy)
        let d: CGFloat = getLength(segment, radius)
        
        var circlePoint = getProportionPoint(angularPoint, d, L, dx, dy)
        
        //StartAngle and EndAngle of arc
        var startAngle = atan2(p1Cross.y - circlePoint.y, p1Cross.x - circlePoint.x)
        var endAngle = atan2(p2Cross.y - circlePoint.y, p2Cross.x - circlePoint.x)
        
        //Sweep angle
        var sweepAngle = endAngle - startAngle
        
        var clockwise = false
        
        //Some additional checks
        if (sweepAngle < 0)
        {
            clockwise = true
            sweepAngle = -sweepAngle
        }
        
        if sweepAngle > .pi {
            clockwise.toggle()
        }
        
        return RoundedCorner(
            roundedRadius: radius,
            roundedPoint: circlePoint,
            cornerPoint: angularPoint,
            leadingPoint: p1,
            trailingPoint: p2,
            leadingCrossPoint: p1Cross,
            trailingCrossPoint: p2Cross,
            leadingAngle: .radians(startAngle),
            trailingAngle: .radians(endAngle),
            clockwise: clockwise
        )
    }
    
    private static func getLength(_ dx: CGFloat, _ dy: CGFloat) -> CGFloat {
        sqrt(dx * dx + dy * dy)
    }
    
    private static func getProportionPoint(_ point: CGPoint,
                                           _ segment: CGFloat,
                                           _ length: CGFloat,
                                           _ dx: CGFloat,
                                           _ dy: CGFloat) -> CGPoint {
        
        let factor: CGFloat = segment / length
        
        return CGPoint(x: point.x - dx * factor,
                       y: point.y - dy * factor)
    }
}
