//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 12/1/2023.
//

import Foundation
public struct ShapeAnalyticsScores {
    public let score: Int

    /// Number of shapes that have that score and have the same number of words
    public let count: Int
    
    public let percentage: Double
    
    public var percentageFromTop: Double
    
    public var nthPosition: Int
    
    public var scorePerWord: Double
    
    public func ToJson() -> String {
        return "{ \"score\": \(score), \"shapes\": \(count), \"percent\": \(percentage), \"nth\":\(nthPosition), \"fromTop\": \(percentageFromTop), \"scorePerWord\": \(scorePerWord) }"
    }
}
