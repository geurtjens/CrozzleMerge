//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 9/1/2023.
//

import Foundation
class RotateShape {

    
    public static func rotateShapes(shapes:[ShapeModel]) -> [ShapeModel] {
        var result: [ShapeModel] = []
        result.reserveCapacity(shapes.count)
        for shape in shapes {
            result.append(rotateShape(shape: shape))
        }
        return result
    }
    
    
    public static func rotateShape(shape: ShapeModel) -> ShapeModel {
        let placements = rotatePlacements(placements:shape.p)
        let result = ShapeModel(s: shape.s, w: shape.h, h: shape.w, p: placements)
        return result
    }
    public static func rotatePlacements(placements: [PlacementModel]) -> [PlacementModel] {
        var result: [PlacementModel] = []
        for placement in placements {
            let rotated = PlacementModel(id: placement.id, x: placement.y, y: placement.x, isHorizontal: !placement.isHorizontal)
            result.append(rotated)
        }
        return result
    }
}
