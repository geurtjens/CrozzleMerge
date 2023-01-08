//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 6/1/2023.
//

import Foundation
// Any shape or even a complete game can be represented in this form
public struct ShapeModel {

    /// The score attributed to this shape as it pertains to crozzle rules
    public let s: UInt16
    
    /// The width of the shape including any blocking characters at the end of the words.
    public let w: UInt8
    
    /// The height of the shape  including any blocking characters.
    public let h: UInt8

    /// The words and how they should be placed into the grid according to the local coordinate system of the shape
    public let p: [PlacementModel]
    
    
    public init(s: UInt16, w: UInt8, h: UInt8, p: [PlacementModel]) {
        self.s = s
        self.w = w
        self.h = h
        self.p = p
    }
    
    
    public init(csv: String) {
        let items = csv.components(separatedBy: ",")
        
        self.s = UInt16(items[0])!
        self.w = UInt8(items[1])!
        self.h = UInt8(items[2])!
        
        let wordCount = (items.count - 3) / 4
        var placements:[PlacementModel] = []
        for i in 0..<wordCount {
            let startPos = 3 + i * 4
            
            let id = UInt8(items[startPos])!
            let x = UInt8(items[startPos + 1])!
            let y = UInt8(items[startPos + 2])!
            let h = Int(items[startPos + 3])!
            
            var isHorizontal = true
            if h == 0 {
                isHorizontal = false
            }
            placements.append(PlacementModel(id:id, x: x, y: y, isHorizontal: isHorizontal))

        }
        
        self.p = placements
    }
    

    public func ToCsv() -> String {
        var placements = ""
        for placement in p {
            if placements != "" {
                placements += ","
            }
            
            var isHorizontal = 0
            if placement.isHorizontal == true {
                isHorizontal = 1
            }
                
            placements += "\(placement.id),\(placement.x),\(placement.y),\(isHorizontal)"
        }
        let result = "\(s),\(w),\(h)," + placements
        return result
    }
}
