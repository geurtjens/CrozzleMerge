//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import Foundation
public class FindMatchingShapes {
    public static func ExecuteAll() -> [MergedModel] {
        print("loading words")
        let wordList = LoadWords.Execute(filename: "8612_Words.txt")
        print("\(wordList.count) words loaded")
        
        print("loading shapes")
        let shapes = LoadShapes.Execute(filename: "8612_Shapes.csv")
        
        // We should filter these shape sizes
        
        

        let (dictionary, shapeAnalysis, analysisJson) = ShapeAnalysisCalculator.execute(shapes: shapes, gameId: 8612)
        print(analysisJson)

        // We are only interested in shapes that meet our score per word minimum
        //let shapes = shapesAll.filter { Int($0.s) / Int($0.p.count) >= scorePerWordMin}
        print("\(shapes.count) shapes accepted")
        
       
        
        
        print("loading shape index")
        let index = LoadWordToShapeIndex.Execute(filename: "8612_ShapeIndex.csv")
        print("\(index.count) index items loaded")
        
        
        
        print("rotating shapes")
        let rotatedShapes = RotateShape.rotateShapes(shapes: shapes)
        print("\(rotatedShapes.count) shapes rotated")
        
        print("finding mergable shapes")
        var result:[MergedModel] = []
        
        //let shapeIncrementAsPercentage = shapes.count / 100
        var totalShapesFound = 0
        for shapeId in 0..<shapes.count {
            
            let foundShapes = Execute(shapeId: shapeId, shapes: shapes, rotatedShapes:rotatedShapes, index: index, wordList: wordList)
            
            
            let filteredFoundShapes = foundShapes.filter { Int($0.score) / Int($0.wordCount) >= 32 }
            
            let mergedModel = MergedModel(shapeId: shapeId, compatibleShapes: filteredFoundShapes)
            // ideally here we just print it to a file, one shape at a time
            //print(mergedModel)
            result.append(mergedModel)
            
            totalShapesFound += filteredFoundShapes.count
            
            if shapeId % 100 == 0 {
                print("\(shapeId) of \(shapes.count) shapes merged, percent complete:\(Double(shapeId) / Double(shapes.count) * Double(100)), total merges so far: \(totalShapesFound)")
            }
        }
        return result
    }
    
    public static func toCsv(mergedModel: MergedModel) -> String {
        var result = ""
        for i in 0..<mergedModel.compatibleShapes.count {
            let item = mergedModel.compatibleShapes[i]
            result += ",\(String(item.indexPos)),\(String(item.wordCount)),\(String(item.score))"
        }
        result = String(mergedModel.shapeId) + "," + result
        
        return result
    }
    
    public static func Execute(shapeId: Int, shapes: [ShapeModel], rotatedShapes: [ShapeModel], index: [[Int]], wordList: [String]) -> [MergedItemModel] {
        
        var result:[MergedItemModel] = []
        
        let shapeA = shapes[shapeId]
        
        let matchingShapes = FindShapesWithMatchingWords(shape: shapeA, index: index)
        
        for matchingShapeId in matchingShapes {
            let shapeB = shapes[matchingShapeId]
            let rotatedShapeB = rotatedShapes[matchingShapeId]
            let (mergeable,shapeText,score,width,height, placements) = ValidateMerge.Execute(shapeA: shapeA, shapeB: shapeB, rotatedShapeB: rotatedShapeB, scoreMin: 0, widthMax: 17, heightMax: 12, wordList: wordList)
            // Our first level is working so now we have to do the last check to see if all the words that are there are not falling along side each other
            if mergeable == true {
                //print(shapeText)
                // Now we must check for overlapping words
                let (hasOverlaps, horizontalWords) = hasOverlappingWordsHorizontal(width: width, height: height, text: shapeText, wordList: wordList)
                
                if hasOverlaps == false {
                    //print("Still need to check vertically")
                    
                    
                    let rotatedPlacements = RotateShape.rotatePlacements(placements: placements)
                    
                    let (validRotated, textRotated,_) = DrawShape.draw(placements: rotatedPlacements, width: height, height: width, wordList: wordList)
                    
                    if validRotated == true {
                        let (hasOverlapsReversed, wordListReversed) = hasOverlappingWordsHorizontal(width: width, height: height, text: textRotated, wordList: wordList)
                        if hasOverlapsReversed == false {
                            if shapeId < matchingShapeId {
                                
                                
                                //let mergedShape = ShapeModel(s: score, w: width, h: height, p: placements)
                                // Update the dictionar
                                result.append(MergedItemModel(indexPos: matchingShapeId, wordCount: UInt8(placements.count), score: UInt16(score)))
                                //result[matchingShapeId] = mergedShape
                                //result.append((shapeId, matchingShapeId, mergedShape))
                                //print(DrawShape.draw(shape: shapeA, wordList: wordList))
                                //print(DrawShape.draw(shape: shapeB, wordList: wordList))
                                //print(shapeText)
                                //print("score: \(score), width:\(width), height: \(height), shapeId:\(shapeId), matchingShapeId:\(matchingShapeId)")
                                //print("\(shapeId),\(matchingShapeId),\(score)")
                                
                            }
                        }
                    }
                }
            }
        }

        // We sort these by the score, but we really also need the number of words to judge if its a good score
        result.sort { $0.score > $1.score}
        
        return result
    }
    
    
    
    
    public static func hasOverlappingWordsHorizontal(width: UInt8, height: UInt8, text: String, wordList:[String]) -> (Bool,[String]) {
        // its perfectly ok to find one consecutive letter as that is just a vertical word
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var words:[String] = []
        var currentWord = ""
        var lastLetter = text[0]
        // The letter can be alphabet, " ", "\n", "."
        for i in 1..<text.count {
            let letter = text[i]
            
            if letter == " " {
                if alphabet.contains(lastLetter) {
                    // It means our word did not end with a . and so its an error
                    if currentWord.count > 1 {
                        return (true, words)
                    } else {
                        currentWord = ""
                    }
                }
            }
            else if letter == "." {
                if alphabet.contains(lastLetter) {
                    if currentWord.count > 1 {
                        // its the end of a word
                        words.append(currentWord)
                        currentWord = ""
                    } else {
                        currentWord = ""
                    }
                }
            }
            else if alphabet.contains(letter) {
                if alphabet.contains(lastLetter) {
                    // word is continuing
                    currentWord += String(letter)
                } else if lastLetter == "." {
                    // start of a word
                    currentWord = String(letter)
                } else if lastLetter == "\n" {
                    // this should not be here
                    if currentWord.count > 1 {
                        return (true, wordList)
                    } else {
                        currentWord = ""
                    }
                } else if lastLetter == " " {
                    // this should not be here as all words start with . and have letters between
                    if i < text.count - 1 {
                        let futureLetter = text[i+1]
                        if alphabet.contains(futureLetter) {
                            return (true, words)
                        }
                    }
                    
                }
            }
            
            else if letter == "\n" {
                if alphabet.contains(lastLetter) {
                    // This cannot be true as a word must end with .
                    if currentWord.count > 1 {
                        return (true, words)
                    } else {
                        currentWord = ""
                    }
                }
            }
            lastLetter = letter
        }
        
        
        
        // So we have no evidence that its bad so lets check if the words given are what we expect
        for word in words {
            if wordList.contains(word) == false {
                return (true, words)
            }
        }
        
        return (false, words)
        
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
