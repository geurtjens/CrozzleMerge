//
//  Test_TextToShape.swift
//  
//
//  Created by Michael Geurtjens on 10/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_TextToShapeCalculator: XCTestCase {

   

    
        //func test_CompatibleDirections() throws {
           
            
           // let wordList = WordRepository.W8809()
            
            //["GLAZE", "NAZARETH"]
            //["ZION", "HAZELNUT"]
            
    //
    //        let shapeB = ShapeModel(s: 0, w: 11, h: 9, p: placementsB)
    //
    //        print(DrawShape.draw(shape: shapeA, wordList: wordList))
    //        print("")
    //        print(DrawShape.draw(shape: shapeB, wordList:wordList))
    //
    //
    //
    //        let rotatedB = RotateShape.rotateShape(shape: shapeB)
    //        print(DrawShape.draw(shape: rotatedB, wordList: wordList))
    //
    //
    //        let (placementsA1, placementsB1, sameOrientation) = ValidateMerge.FindCommonWords(placementsA: shapeA.p, placementsB: shapeB.p)
    //
    //
    //        let (success, shapeText, score, width, height, placements) = ValidateMerge.Execute(shapeA: shapeA, shapeB: shapeB, rotatedShapeB: rotatedB, scoreMin:0, widthMax: 17, heightMax: 12, wordList: wordList)
    //
    //        XCTAssertTrue(success)
    //        print(shapeText)
    //
    //        // We are trying to reproduce this error here:
    //        /*           .
    //               .GLAZE.
    //                   I H
    //           .BELLS. O A
    //                 C.NAZARETH.
    //                 R . E
    //                 E   L
    //                 A   N
    //                 M   U
    //                 .   T
    //                     .
    //           */
        //}

    func test_ThatCodeIsGeneratedCorrectly() throws {
            
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
            //print(codeA)
            
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
            //print(codeB)
            
        let expectedCodeB = "" +
            "let placements = [PlacementModel(id: 23, x: 0, y: 2, isHorizontal: true),PlacementModel(id: 6, x: 1, y: 4, isHorizontal: true),PlacementModel(id: 25, x: 4, y: 0, isHorizontal: false),PlacementModel(id: 83, x: 6, y: 2, isHorizontal: false)]\n\n" +

            "let shape = ShapeModel(s: 0, w: 11, h: 9, p: placements)\n"

        //print(expectedCodeB)
        //print(DrawShape.flatDraw(text: expectedCodeB))
        //print(DrawShape.flatDraw(text: codeB))
        
        XCTAssertEqual(codeB,expectedCodeB)
        
    }

    

}
