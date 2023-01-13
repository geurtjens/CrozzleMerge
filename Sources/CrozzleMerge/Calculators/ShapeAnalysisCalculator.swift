//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 12/1/2023.
//

import Foundation

/// I want to find out how the scores are broken down for a large group of shapes and then work out what score is required for each number of shapes
public class ShapeAnalysisCalculator {
    
    // Each number of words has a count and each score has a number of shapes that have that count
    
    public static func execute(shapes: [ShapeModel], gameId: Int) -> ([Int:[Int:Int]], ShapeAnalyticsSummary, String) {
        var result:[Int:[Int:Int]] = [:]
        
        for shapeId in 0..<shapes.count {
            let shape = shapes[shapeId]
            
            let wordCount = Int(shape.p.count)
            let score = Int(shape.s)
            
            if result[wordCount] == nil {
                result[wordCount] = [score:1]
            } else {
                var item = result[wordCount]!
                var itemScore = item[score]
                if itemScore == nil {
                    item[score] = 1
                    result[wordCount] = item
                } else {
                    itemScore = itemScore! + 1
                    item[score] = itemScore
                    result[wordCount] = item
                }
            }
        }
        
        let shapeAnalyticsSummary = ShapeAnalyticsSummary(input:result, gameId: gameId)
        let json = shapeAnalyticsSummary.ToJson()
        return (result, shapeAnalyticsSummary, json)
    }
}
