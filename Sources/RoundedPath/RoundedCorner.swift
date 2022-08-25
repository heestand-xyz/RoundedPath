//
//  Created by Anton Heestand on 2022-08-25.
//

import CoreGraphics
import SwiftUI

struct RoundedCorner {
    
    let roundedRadius: CGFloat
    let roundedPoint: CGPoint
    
    let cornerPoint: CGPoint
    
    let leadingPoint: CGPoint
    let trailingPoint: CGPoint
    
    let leadingCrossPoint: CGPoint
    let trailingCrossPoint: CGPoint
    
    let leadingAngle: Angle
    let trailingAngle: Angle
    let clockwise: Bool
}
