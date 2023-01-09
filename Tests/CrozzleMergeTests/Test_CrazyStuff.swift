//
//  Test_CrazyStuff.swift
//  
//
//  Created by Michael Geurtjens on 9/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_CrazyStuff: XCTestCase {

    func test2() throws {
       
        
        let wordList = WordRepository.W8809()
        
        //["GLAZE", "NAZARETH"]
        //["ZION", "HAZELNUT"]
        let placementsA = [PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true),PlacementModel(id: 0, x: 4, y: 0, isHorizontal: false),PlacementModel(id: 4, x: 6, y: 1, isHorizontal: false)]

        let shapeA = ShapeModel(s: 0, w: 13, h: 11, p: placementsA)

        //["BELLS", "NAZARETH"]
        //["GLAZE", "CREAM"]
        let placementsB = [PlacementModel(id: 23, x: 0, y: 2, isHorizontal: true),PlacementModel(id: 6, x: 1, y: 4, isHorizontal: true),PlacementModel(id: 25, x: 4, y: 0, isHorizontal: false),PlacementModel(id: 83, x: 6, y: 2, isHorizontal: false)]

        let shapeB = ShapeModel(s: 0, w: 11, h: 9, p: placementsB)

        print(DrawShape.draw(shape: shapeA, wordList: wordList))
        print("")
        print(DrawShape.draw(shape: shapeB, wordList:wordList))
        
        

        let rotatedB = RotateShape.rotateShape(shape: shapeB)
        
        let (success, shapeText, score, width, height, placements) = ValidateMerge.Execute(shapeA: shapeA, shapeB_: shapeB, rotatedShapeB: rotatedB, scoreMin:0, widthMax: 17, heightMax: 12, wordList: wordList)
        
        XCTAssertTrue(success)
        print(shapeText)
        
        // We are trying to reproduce this error here:
        /*           .
               .GLAZE.
                   I H
           .BELLS. O A
                 C.NAZARETH.
                 R . E
                 E   L
                 A   N
                 M   U
                 .   T
                     .
           */
    }

    func testExample() throws {
        
        let wordList = WordRepository.W8809()
        
        let textA = "" +
        "    .        \n" +
        ".GLAZE.      \n" +
        "    I H      \n" +
        "    O A      \n" +
        "   .NAZARETH.\n" +
        "    . E      \n" +
        "      L      \n" +
        "      N      \n" +
        "      U      \n" +
        "      T      \n" +
        "      .      "

        let codeA = TextToShapeCalculator.TextToCode(shapeText: textA, wordList: wordList)
        print(codeA)
        
//        let placementsA = [PlacementModel(id: 0, x: 4, y: 0, isHorizontal: true),PlacementModel(id: 4, x: 6, y: 1, isHorizontal: true),PlacementModel(id: 25, x: 0, y: 1, isHorizontal: false),PlacementModel(id: 6, x: 3, y: 4, isHorizontal: false)]

  //      let shapeA = ShapeModel(s: 0, w: 13, h: 11, p: placementsA)
        
        
        let textB = "" +
        "    .      \n" +
        "    G      \n" +
        ".BELLS.    \n" +
        "    A C    \n" +
        " .NAZARETH.\n" +
        "    E E    \n" +
        "    . A    \n" +
        "      M    \n" +
        "      .    "
        
        let codeB = TextToShapeCalculator.TextToCode(shapeText: textB, wordList: wordList)
        print(codeB)
        
   
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
