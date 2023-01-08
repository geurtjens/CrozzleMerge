//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 6/1/2023.
//

import Foundation
public class FindWordMatches {
    
    
    public static func Execute(wordCount: Int, shapes: [ShapeModel]) -> [[Int]] {
        var result:[[Int]] = []
        for wordId in 0..<wordCount {
            let array = Execute(wordId:UInt8(wordId), shapes: shapes)
            result.append(array)
        }
        return result
    }
    
    public static func Execute(wordId: UInt8, shapes: [ShapeModel]) -> [Int] {
        
        // create a list of shape locations that have the word that we are looking for
        
        var positions:[Int] = []
        
        for i in 0..<shapes.count {
            let shape = shapes[i]
            
            for placement in shape.p {
                if placement.id == wordId {
                    positions.append(i)
                    break
                }
            }
        }
        return positions
    }
}
