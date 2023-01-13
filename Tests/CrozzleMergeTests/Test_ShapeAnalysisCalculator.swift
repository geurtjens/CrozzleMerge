//
//  Test_ShapeAnalysisCalculator.swift
//  
//
//  Created by Michael Geurtjens on 12/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_ShapeAnalysisCalculator: XCTestCase {

   

    func testExample() throws {
        
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 0, x: 4, y: 0, isHorizontal: false),
            PlacementModel(id: 4, x: 6, y: 1, isHorizontal: false),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)
        ]
        let shapeA = ShapeModel(s: 176, w: 13, h: 11, p:placementsA)

        let shapeB = ShapeModel(s: 176, w: 13, h: 11, p:placementsA)
        
        let shapeC = ShapeModel(s: 170, w: 13, h: 11, p:placementsA)
        
        let placementsD = [
            PlacementModel(id: 4, x: 1, y: 0, isHorizontal: false),
            PlacementModel(id: 2, x: 0, y: 8, isHorizontal: true)
        ]
        let shapeD = ShapeModel(s: 56, w: 6, h: 10, p: placementsD)
        
        let shapes = [shapeA, shapeB, shapeC, shapeD]
        
        // We introduce 3 shapes with 4 words and one shape with 2 words
        let (dictionary,analysis,json) = ShapeAnalysisCalculator.execute(shapes: shapes, gameId: 10)
        
        
        let twoWords = dictionary[2]
        let fourWords = dictionary[4]
        
        XCTAssertNotNil(twoWords)
        XCTAssertNotNil(fourWords)
        
        // for words with 2 words, we have 1 unique score
        XCTAssertEqual(twoWords!.count, 1)
        
        // for shapes with 4 words, we have 2 unique scores
        XCTAssertEqual(fourWords!.count, 2)
        
        // for shapes with 2 words, the score of 56 is shared with only 1 shape
        XCTAssertEqual(twoWords![56], 1)
        
        // for shapes with 4 words, the score of 170 is shared with only 1 shape
        XCTAssertEqual(fourWords![170]!,1)
        
        // for shapes with 4 words, the score of 176 is shared with 2 shapes
        XCTAssertEqual(fourWords![176]!,2)
 
        
        var twoWordCount = 0
        for item in twoWords! {
            twoWordCount += item.value
        }
        // There is only 1 shape with two words
        XCTAssertEqual(twoWordCount,1)
        
        
        var fourWordCount = 0
        for item in fourWords! {
            fourWordCount += item.value
        }
        // There are 3 shapes with four words
        XCTAssertEqual(fourWordCount,3)
        
        
        
        
        print(dictionary)
        print(analysis)
        print(json)
    }


}
