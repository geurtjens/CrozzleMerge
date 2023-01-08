//
//  Test_FindWordMatches.swift
//  
//
//  Created by Michael Geurtjens on 6/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_FindWordMatches: XCTestCase {


    func testExample() throws {
        let shapes = LoadShapes.Execute(filename: "8612_Shapes.csv")
        
        let gameModel = GameModel()
        
        let wordList = gameModel.grids[0].words

        //let wordCount = wordList.count
        let wordMatchFor0 = FindWordMatches.Execute(wordId: 0, shapes: shapes)
        XCTAssertEqual(wordMatchFor0.count,2)
    }
    
    func testExample2() throws {
        let shapes = LoadShapes.Execute(filename: "8612_Shapes.csv")
        
        let gameModel = GameModel()
        
        let wordList = gameModel.grids[0].words

        let wordCount = wordList.count
        let wordMatchFor0 = FindWordMatches.Execute(wordCount: wordCount, shapes: shapes)
        
        var result = ""
        for i in 0..<wordMatchFor0.count {
            let matches = wordMatchFor0[i]
            var line = ""
            for j in 0..<matches.count {
                if line != "" {
                    line += ","
                }
                line += String(matches[j])
            }
            line = String(i) + "," + line + "\n"
            result.append(line)
        }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dirPath = paths[0]
        let filename = dirPath.appendingPathComponent("\(gameModel.grids[0].id)_wordIndex.csv")
        
        do {
            try result.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            print("ERROR WHEN SAVING")
        }
        result = ""
        print(filename)
        for i in 0..<shapes.count {
            let shape = shapes[i]

            var totalShapesWithSameWords:[Int] = []
            // we find all shapes that contain each and every word in this particular shape
            for placement in shape.p {
                let otherShapes = wordMatchFor0[Int(placement.id)]

                totalShapesWithSameWords = totalShapesWithSameWords + otherShapes

            }
            // Then we sort them
            totalShapesWithSameWords.sort()

            // can we now see how many of that word instance there is so we can exclude it if it has the same number as our words have meaning its a subset
            // https://www.hackingwithswift.com/example-code/language/how-to-count-element-frequencies-in-an-array
            let mappedItems = totalShapesWithSameWords.map { ($0, 1) }
            // This tells us which shape and how many common words between that shape and ours.  Its the beginning of something useful because we must ignore all shapes that have the same number of common words as is in our shape.
            let counts = Dictionary(mappedItems, uniquingKeysWith: +)

            let shape2 = shapes[2869242]

            // Now we check if both of the common words are both same orientation or both different orientation.

            // Then we get one of the common words and see if the other common word is in same position relative to the word we have chosen as the reference word.

            // Calculate the new width and height to make sure it complies with widthMax and heightMax

            // Then we place the words

            // Then we see if the placed words are correct and havent been overlapped

            // If all that happens then we calculate the new score and make that connection of the two shapes and the resultant score and number of words.

            print(counts)
        }

        
        
        XCTAssertEqual(wordMatchFor0.count,wordCount)
    }

    func testExample3() throws {
        let shapes = LoadShapes.Execute(filename: "8612.csv")
        
        let gameModel = GameModel()
        
        let wordList = gameModel.grids[0].words

        let wordCount = wordList.count
        let wordMatchFor0 = FindWordMatches.Execute(wordCount: wordCount, shapes: shapes)
        
        var possibleConnections:[(Int,Int)] = []
        for i in 0..<shapes.count {
            let shape = shapes[i]

            var totalShapesWithSameWords:[Int] = []
            // we find all shapes that contain each and every word in this particular shape
            for placement in shape.p {
                let otherShapes = wordMatchFor0[Int(placement.id)]

                totalShapesWithSameWords = totalShapesWithSameWords + otherShapes

            }
            // Then we sort them
            totalShapesWithSameWords.sort()

            // can we now see how many of that word instance there is so we can exclude it if it has the same number as our words have meaning its a subset
            // https://www.hackingwithswift.com/example-code/language/how-to-count-element-frequencies-in-an-array
            let mappedItems = totalShapesWithSameWords.map { ($0, 1) }
            // This tells us which shape and how many common words between that shape and ours.  Its the beginning of something useful because we must ignore all shapes that have the same number of common words as is in our shape.
            let counts = Dictionary(mappedItems, uniquingKeysWith: +)

            for item in counts {
                
                // If it isnt a subset, having every single word as our origin shape
                if item.value != shape.p.count {
                    // This is the matching shape
                    let shape2 = shapes[item.key]
                    
                    
                    
                    // FIND OUT IF ALL COMMON WORDS HAVE SAME ORIENTATION
                    
                    // Find the common words
                    var shape1CommonWords:[PlacementModel] = []
                    var shape2CommonWords:[PlacementModel] = []
                    
                    for shape1Placement in shape.p {
                        for shape2Placement in shape2.p {
                            if shape1Placement.id == shape2Placement.id {
                                shape1CommonWords.append(shape1Placement)
                                shape2CommonWords.append(shape2Placement)
                            }
                        }
                    }
                    var isSameOrientation = true
                    if shape1CommonWords[0].isHorizontal != shape2CommonWords[0].isHorizontal {
                        isSameOrientation = false
                    }

                    var isValidOrientation = true
                    // So we should find that they are all same orientation or all not same orientation
                    for i in 0..<shape1CommonWords.count {
                        if isSameOrientation {
                            if shape1CommonWords[i].isHorizontal != shape2CommonWords[i].isHorizontal {
                                isValidOrientation = false
                            }
                        } else {
                            if shape1CommonWords[i].isHorizontal == shape2CommonWords[i].isHorizontal {
                                isValidOrientation = false
                            }
                        }
                    }
                    
                    if isValidOrientation {
                        // Then we get one of the common words and see if the other common word is in same position relative to the word we have chosen as the reference word.
                        
                        possibleConnections.append((i,item.key))
                    }
                }
            }
            
            // Then we get one of the common words and see if the other common word is in same position relative to the word we have chosen as the reference word.

            // So from this point we are identifying which words might go together, perhaps we stop here and continue with other tests later
            
            // Calculate the new width and height to make sure it complies with widthMax and heightMax

            // Then we place the words

            // Then we see if the placed words are correct and havent been overlapped

            // If all that happens then we calculate the new score and make that connection of the two shapes and the resultant score and number of words.
            print(possibleConnections.count)
            
            print(counts)
        }

        
        
        XCTAssertEqual(wordMatchFor0.count,wordCount)
    }
}
