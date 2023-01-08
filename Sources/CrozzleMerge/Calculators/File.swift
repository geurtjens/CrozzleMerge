//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import Foundation
public class FindMatchingShapes {
    public static func Execute() {
        let wordList = LoadWords.Execute(filename: "8612_Words.txt")
        let shapes = LoadShapes.Execute(filename: "8612_Shapes.csv")
        let index = LoadWordToShapeIndex.Execute(filename: "8612_ShapeIndex.csv")
        var result:[(Int,Int)] = []
        for shapeId in 0..<shapes.count {
            let shapeA = shapes[shapeId]
            
            let matchingShapes = FindShapesWithMatchingWords(shape: shapeA, index: index)
            
            for matchingShapeId in matchingShapes {
                let shapeB = shapes[matchingShapeId]
                
                let (mergeable,shapeText,score,width,height) = ValidateMerge.Execute(shapeA: shapeA, shapeB: shapeB, scoreMin: 0, widthMax: 17, heightMax: 12, wordList: wordList)
                // Our first level is working so now we have to do the last check to see if all the words that are there are not falling along side each other
                if mergeable == true {
                    result.append((shapeId,matchingShapeId))
                    print(DrawShape.draw(shape: shapeA, wordList: wordList))
                    print(DrawShape.draw(shape: shapeB, wordList: wordList))
                    print(shapeText)
                    print(score, width, height)
                }
            }
        }
    }
    
    
    /// Gives the location of all shapes that have matching words with the given shape
    public static func FindShapesWithMatchingWords(shape: ShapeModel, index:[[Int]]) -> [Int] {
        var totalShapesWithSameWords:[Int] = []
        // we find all shapes that contain each and every word in this particular shape
        for placement in shape.p {
            let otherShapes = index[Int(placement.id)]

            totalShapesWithSameWords = totalShapesWithSameWords + otherShapes

        }
        // Then we sort them
        totalShapesWithSameWords.sort()

        // can we now see how many of that word instance there is so we can exclude it if it has the same number as our words have meaning its a subset
        // https://www.hackingwithswift.com/example-code/language/how-to-count-element-frequencies-in-an-array
        let mappedItems = totalShapesWithSameWords.map { ($0, 1) }
        // This tells us which shape and how many common words between that shape and ours.  Its the beginning of something useful because we must ignore all shapes that have the same number of common words as is in our shape.
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)

        let shapeWordCount = shape.p.count
        
        let filtered = counts.filter { $0.value < shapeWordCount }
        
        let shapeIds = filtered.map { $0.key }

        return shapeIds
    }
}
