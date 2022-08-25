//
//  Created by Anton Heestand on 2022-08-25.
//

import SwiftUI

extension Path {
    
    public func rounded(_ cornerRadius: CGFloat) -> Path {
        
        var points: [CGPoint] = []
        cgPath.applyWithBlock { element in
            points.append(element.pointee.points.pointee)
        }
        
        let roundedCorners: [RoundedCorner] = { () -> [RoundedCorner] in
            
            var roundedCorners: [RoundedCorner] = []
            
            for (index, point) in points.enumerated() {
                
                let previousPoint = index == 0 ? points.last! : points[index - 1]
                let nextPoint = index == points.count - 1 ? points.first! : points[index + 1]
                
                let roundedCorner: RoundedCorner = .create(at: point, from: previousPoint, to: nextPoint, radius: cornerRadius)
                roundedCorners.append(roundedCorner)
            }
            
            return roundedCorners
        }()
        
        return Path { path in
            for roundedCorner in roundedCorners {
                path.addArc(center: roundedCorner.roundedPoint,
                            radius: roundedCorner.roundedRadius,
                            startAngle: roundedCorner.leadingAngle,
                            endAngle: roundedCorner.trailingAngle,
                            clockwise: roundedCorner.clockwise)
            }
            path.closeSubpath()
        }
    }
}
