//
//  RoundedPath.swift
//  Cardboard Demo
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2023-08-23.
//

import Foundation
import SwiftUI

public struct RoundedPath {
    
    let leadingPoint: CGPoint
    let roundedCorners: [RoundedCorner]
    let trailingPoint: CGPoint
    let closed: Bool
    
    public var path: Path {
        Path { path in
            if !closed {
                path.move(to: leadingPoint)
            }
            for roundedCorner in roundedCorners {
                path.addArc(center: roundedCorner.roundedPoint,
                            radius: roundedCorner.roundedRadius,
                            startAngle: roundedCorner.leadingAngle,
                            endAngle: roundedCorner.trailingAngle,
                            clockwise: roundedCorner.clockwise)
            }
            if closed {
                path.closeSubpath()
            } else {
                path.addLine(to: trailingPoint)
            }
        }
    }
    
    public func sample(at offset: CGFloat) -> CGPoint {
        .zero
    }
    
    public func length() -> CGFloat {
        0.0
    }
}
