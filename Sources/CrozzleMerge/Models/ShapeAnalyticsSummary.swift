//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 12/1/2023.
//

import Foundation
public struct ShapeAnalyticsSummary {
    let wordCountAndTheirScores:[ShapeAnalyticsWords]
    let game: Int
    let totalShapes: Int
    init(input:[Int:[Int:Int]], gameId: Int) {
        
        var result: [ShapeAnalyticsWords] = []
        
        var totalShapesFound = 0
        for item in input {
            let wordCount = item.key
            let scores = item.value
            var totalShapesPerWordCount = 0
            for score in scores {
                totalShapesPerWordCount += score.value
            }
            
            

            var shapeAnalyticsScores:[ShapeAnalyticsScores] = []
            for score in scores {

                let scorePerWord = Double(score.key) / Double(wordCount)
                let numberOfShapes = score.value
                
                let percentage = Double(numberOfShapes) / Double(totalShapesPerWordCount) * Double(100)
                
                shapeAnalyticsScores.append(ShapeAnalyticsScores(score:score.key, count: score.value, percentage: percentage, percentageFromTop: 0, nthPosition:0, scorePerWord: scorePerWord))
            }
            shapeAnalyticsScores.sort { $0.score > $1.score}
            
            var runningTotalOfShapeCount = 0
            for i in 0..<shapeAnalyticsScores.count {
                // Now we will calculate how many from the top this is
                runningTotalOfShapeCount += shapeAnalyticsScores[i].count
                let runningPercentage = Double(runningTotalOfShapeCount) / Double(totalShapesPerWordCount) * Double(100)
                shapeAnalyticsScores[i].percentageFromTop = runningPercentage
                shapeAnalyticsScores[i].nthPosition = runningTotalOfShapeCount
            }
            
            totalShapesFound += totalShapesPerWordCount
            
            result.append(ShapeAnalyticsWords(wordCount: wordCount, totalShapes: totalShapesPerWordCount, scoreBreakdown: shapeAnalyticsScores))
            
            
        }
        result.sort { $0.wordCount < $1.wordCount }
        wordCountAndTheirScores = result
        totalShapes = totalShapesFound
        game = gameId
    }
    public func ToJson() -> String {
        
        var result = ""
       
        for wordCount in wordCountAndTheirScores {

            if result != "" {
                result += ",\n"
            }
            result += wordCount.ToJson()
        }
        return "{ \"game\": \(game), \"shapeCount\": \(totalShapes), \"breakdown\": [\n" + result + "\n]}"
    }
    
}
