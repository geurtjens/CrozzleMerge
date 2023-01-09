//
//  Test_ValidateMerge.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_ValidateMerge: XCTestCase {

    
    func test_MustMergeAllPlacementsChanged() throws {
    
        let shapeA = "" +
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
      
        let shapeB = "" +
              "   .          \n" +
              "  .GLAZE.     \n" +
              "   R    R     \n" +
              "   E    A     \n" +
              "   E    I     \n" +
              "   T    S     \n" +
              ".KRISSKRINGLE.\n" +
              "   N    N     \n" +
              "   G    S     \n" +
              "   S    .     \n" +
              "   .          "
        
        
        
        let merged = "" +
              "   .          \n" +
              "  .GLAZE.     \n" +
              "   R  I R     \n" +
              "   E  O A     \n" +
              "   E  NA#ARETH.     \n" +
              "   T    S     \n" +
              ".KRISSKRINGLE.\n" +
              "   N    N     \n" +
              "   G    S     \n" +
              "   S    .     \n" +
              "   .          "
        
        let offsetX = -2
        let offsetY = 6
        let width = 15
        let height = 11
        
    }
    
    
    
    func test_Execute() throws {
        
        let wordList = ["ZION","AZURE","TOYS","JOY","HAZELNUT","NUTS","NAZARETH","HYMN","TURKEY","SNOW","MERRY","TOAST","STAR","HOLLY","JELLY","FAMILY","WHITE","SING","SAUCE","PORK","TREE","EVE","INN","BELLS","CAKE",
            "GLAZE","PARTYHATS","TWENTYFIFTH","WALNUT","PEANUTS","PRESENTS","FRUIT","NUTMEG","CUSTARD","CHRISTMAS","MISTLETOE","GIFTS","SANTACLAUS","FESTIVE","RAISINS","LIGHTS","WREATH","HOLIDAY","WISEMEN","CRANBERRY","OPENHOUSE","SILENTNIGHT","STOCKING","PUNCH","WINE","SHOPPING","PLUMPUDDING","WRAPPING","NEIGHBOURS","GREETINGS","DECORATIONS","ALMONDS","LANTERN","KRISSKRINGLE","SPICE","GOODWILL","BONBON","CHURCH","FRIENDS","PARCELS","CINNAMON","NICHOLAS","MINCEPIES","CHERRIES","SLEIGH","ALMOND","MANGER","RIBBON","CHOCOLATE","MIXEDPEEL","DRINK","CANDLES","FOOD","GINGER","BETHLEHEM","CAROL","REINDEER","GOODCHEER","CREAM","CORDIAL","CHILDREN","ICECREAM","CHICKEN","CARD","DECEMBER","PEACE"]
        
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 0, x: 4, y: 0, isHorizontal: false),
            PlacementModel(id: 4, x: 6, y: 1, isHorizontal: false),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)
        ]
        let shapeA = ShapeModel(s: 176, w: 13, h: 11, p:placementsA)
        
        
        let expectedA = "" +
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
        
        let textA = DrawShape.draw(shape: shapeA, wordList: wordList)
        XCTAssertEqual(textA, expectedA)
        
        let placementsB = [
            PlacementModel(id: 4, x: 1, y: 0, isHorizontal: false),
            PlacementModel(id: 2, x: 0, y: 8, isHorizontal: true)
        ]
        let shapeB = ShapeModel(s: 56, w: 6, h: 10, p: placementsB)
        
        let rotatedShapeB = RotateShape.rotateShape(shape: shapeB)
        
        let textB = DrawShape.draw(shape: shapeB, wordList: wordList)
        let textC = DrawShape.draw(shape: rotatedShapeB, wordList:wordList)
        
        let expectedB = "" +
             " .    \n" +
             " H    \n" +
             " A    \n" +
             " Z    \n" +
             " E    \n" +
             " L    \n" +
             " N    \n" +
             " U    \n" +
             ".TOYS.\n" +
             " .    "
        print(textB)
        print(textC)
        XCTAssertEqual(textB,expectedB)
        
        let expectedMergeText = "" +
            "    .        \n" +
            ".GLAZE.      \n" +
            "    I H      \n" +
            "    O A      \n" +
            "   .NAZARETH.\n" +
            "    . E      \n" +
            "      L      \n" +
            "      N      \n" +
            "      U      \n" +
            "     .TOYS.  \n" +
            "      .      "
        print(expectedA)
        print(expectedMergeText)
        
        let (success, shapeText, score, width, height, placements) = ValidateMerge.Execute(shapeA:shapeA, shapeB: shapeB, rotatedShapeB: rotatedShapeB, scoreMin: 0, widthMax: 17, heightMax: 12, wordList: wordList)
        
        XCTAssertTrue(success)
        XCTAssertEqual(score, 202)
        XCTAssertEqual(width, 13)
        XCTAssertEqual(height, 11)
        XCTAssertEqual(shapeText, expectedMergeText)
        
        print(shapeText)
        
        print(expectedA)
        print(expectedB)
        print(expectedMergeText)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func test_CheckDistances() throws {
        let placementsA = [
            PlacementModel(id:0,x:0,y:0,isHorizontal: true),
            PlacementModel(id:1,x:2,y:3,isHorizontal: false),
            PlacementModel(id:1,x:8,y:9,isHorizontal: false)
        ]
        
        let resultA = ValidateMerge.CheckDistances(placements: placementsA)
        XCTAssertEqual(resultA.count, 2)
        
        // We are measuring the distance from the first one to all the other ones
        XCTAssertEqual(resultA[0].0, -2)
        XCTAssertEqual(resultA[0].1, -3)
        XCTAssertEqual(resultA[1].0, -8)
        XCTAssertEqual(resultA[1].1, -9)
        
        let placementsB = [
            PlacementModel(id:0,x:10,y:10,isHorizontal: true),
            PlacementModel(id:1,x:2,y:3,isHorizontal: false),
            PlacementModel(id:1,x:8,y:9,isHorizontal: false)
        ]
        let resultB = ValidateMerge.CheckDistances(placements: placementsB)
        XCTAssertEqual(resultB.count, 2)
        
        // We are measuring the distance from the first one to all the other ones
        let x1 = resultB[0].0
        let y1 = resultB[0].1
        XCTAssertEqual(x1, 8)
        XCTAssertEqual(y1, 7)
        XCTAssertEqual(resultB[1].0, 2)
        XCTAssertEqual(resultB[1].1, 1)
        
    }
    
    func test_DistanceSameOrientation_True() throws {
        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: true),
            PlacementModel(id:1,x:3,y:4,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: true),
            PlacementModel(id:1,x:7,y:8,isHorizontal: false)
        ]
        
        let result = ValidateMerge.DistanceSameOrientation(placementsA: placementsA, placementsB: placementsB)
        
        XCTAssertTrue(result)
    }
    
    
    
    
    func test_DistanceSameOrientation_False() throws {
        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: true),
            PlacementModel(id:1,x:3,y:4,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: true),
            PlacementModel(id:1,x:7,y:7,isHorizontal: false)
        ]
        
        let result = ValidateMerge.DistanceSameOrientation(placementsA: placementsA, placementsB: placementsB)
        
        XCTAssertFalse(result)
    }
    
    func test_WidthSameOrientation_SameConnectionPoint() throws {
        let width = ValidateMerge.widthSameOrientation(widthA: 10, widthB: 10, xA: 5, xB: 5)
        XCTAssertEqual(width, 10)
    }
    func test_WidthSameOrientation_DifferentConnectionPoint() throws {
        let width = ValidateMerge.widthSameOrientation(widthA: 10, widthB: 10, xA: 5, xB: 4)
        XCTAssertEqual(width, 11)
    }
    func test_WidthSameOrientation_DifferentConnectionPoint2() throws {
        let width = ValidateMerge.widthSameOrientation(widthA: 10, widthB: 10, xA: 5, xB: 6)
        XCTAssertEqual(width, 11)
    }
    // What if the width of B is one less than A and position of B is right by 1
    // I would reason that width is 10
    
    // ".....X...."
    // "....X..."
    func test_WidthSameOrientation_DifferentConnectionPoint3() throws {
        let width = ValidateMerge.widthSameOrientation(widthA: 10, widthB: 9, xA: 5, xB: 4)
        XCTAssertEqual(width, 10)
    }
    
    // We should be expanding to the left
    // "....X....."
    // ".....X..."
    func test_WidthSameOrientation_DifferentConnectionPoint7() throws {
        let width = ValidateMerge.widthSameOrientation(widthA: 10, widthB: 9, xA: 5, xB: 6)
        XCTAssertEqual(width, 11)
    }
    // We should be expanding to the right
    // ".....X...."
    // "...X....."
    func test_WidthSameOrientation_DifferentConnectionPoint8() throws {
        let width = ValidateMerge.widthSameOrientation(widthA: 10, widthB: 9, xA: 5, xB: 3)
        XCTAssertEqual(width, 11)
    }
    
    
}
