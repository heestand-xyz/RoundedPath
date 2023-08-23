//
//  Created by Anton Heestand on 2022-08-25.
//

import SwiftUI

extension Path {
    
    public func rounded(_ cornerRadius: CGFloat, closed: Bool = true) -> Path {
        roundedPath(cornerRadius, closed: closed).path
    }
    
    public func roundedPath(_ cornerRadius: CGFloat, closed: Bool = true) -> RoundedPath {
        
        var points: [CGPoint] = []
        cgPath.applyWithBlock { element in
            points.append(element.pointee.points.pointee)
        }
        if points.isEmpty {
            return RoundedPath(leadingPoint: .zero,
                               roundedCorners: [],
                               trailingPoint: .zero,
                               closed: closed)
        }
        if points.count < 3 {
            return RoundedPath(leadingPoint: points.first!,
                               roundedCorners: [],
                               trailingPoint: points.last!,
                               closed: closed)
        }
        
        let roundedCorners: [RoundedCorner] = { () -> [RoundedCorner] in
            
            var roundedCorners: [RoundedCorner] = []
            
            for (index, point) in points.enumerated() {
                
                if !closed {
                    guard index > 0, index < points.count - 1 else { continue }
                }
                
                let previousPoint = index == 0 ? points.last! : points[index - 1]
                let nextPoint = index == points.count - 1 ? points.first! : points[index + 1]
                
                let roundedCorner: RoundedCorner = .create(at: point, from: previousPoint, to: nextPoint, radius: cornerRadius)
                roundedCorners.append(roundedCorner)
            }
            
            return roundedCorners
        }()
        
        return RoundedPath(leadingPoint: points.first!,
                           roundedCorners: roundedCorners,
                           trailingPoint: points.last!,
                           closed: closed)
    }
}
