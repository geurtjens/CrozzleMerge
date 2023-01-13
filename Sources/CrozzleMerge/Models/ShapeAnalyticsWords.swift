//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 12/1/2023.
//

import Foundation
public struct ShapeAnalyticsWords {
    public let wordCount: Int
    public let totalShapes: Int
    public let scoreBreakdown: [ShapeAnalyticsScores]
    
    public func ToJson() -> String {
        var result = "    { \"wordCount\": \(wordCount), \"totalShapes\": \(totalShapes), \"scoreBreakdown\": [\n"
        
        var scoreText = ""
        for score in scoreBreakdown {
            if scoreText != "" {
                scoreText += ",\n"
            }
            scoreText += "        " + score.ToJson()
        }
        result += scoreText + "\n    ]}"
        return result
    }
}
