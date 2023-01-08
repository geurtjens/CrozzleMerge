//
//  Test_FileManagement.swift
//  
//
//  Created by Michael Geurtjens on 6/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_LoadShapes: XCTestCase {

    func testExample() throws {
        let shapes = LoadShapes.Execute(filename: "8612.csv")
        let shape = shapes[0]
        
        let gameModel = GameModel()
        
        let wordList = gameModel.grids[0].words
        
        let text = DrawShape.draw(shape: shape, wordList: wordList)
        print(text)
        XCTAssertEqual(shapes.count,4468963)
    }

    func test_hasOverlappingWordsHorizontal() throws {
        let width = UInt8(13)
        let height = UInt8(12)
        let wordList = ["ZION","AZURE","TOYS","JOY","HAZELNUT","NUTS","NAZARETH","HYMN","TURKEY","SNOW","MERRY","TOAST","STAR","HOLLY","JELLY","FAMILY","WHITE","SING","SAUCE","PORK","TREE","EVE","INN","BELLS","CAKE",
                                       "GLAZE","PARTYHATS","TWENTYFIFTH","WALNUT","PEANUTS","PRESENTS","FRUIT","NUTMEG","CUSTARD","CHRISTMAS","MISTLETOE","GIFTS","SANTACLAUS","FESTIVE","RAISINS","LIGHTS","WREATH","HOLIDAY","WISEMEN","CRANBERRY","OPENHOUSE","SILENTNIGHT","STOCKING","PUNCH","WINE","SHOPPING","PLUMPUDDING","WRAPPING","NEIGHBOURS","GREETINGS","DECORATIONS","ALMONDS","LANTERN","KRISSKRINGLE","SPICE","GOODWILL","BONBON","CHURCH","FRIENDS","PARCELS","CINNAMON","NICHOLAS","MINCEPIES","CHERRIES","SLEIGH","ALMOND","MANGER","RIBBON","CHOCOLATE","MIXEDPEEL","DRINK","CANDLES","FOOD","GINGER","BETHLEHEM","CAROL","REINDEER","GOODCHEER","CREAM","CORDIAL","CHILDREN","ICECREAM","CHICKEN","CARD","DECEMBER","PEACE"]
        
        let text = "" +
    "    .        \n" +
    ".GLAZE.  .   \n" +
    "    I H  O . \n" +
    "    O A  P C \n" +
    "   .NAZARETH.\n" +
    "    . E  N U \n" +
    "      L  H R \n" +
    "      N  O C \n" +
    "      U  U H \n" +
    "     .TOAST. \n" +
    "      .  E   \n" +
    "         .   "
        print(text)
        let (hasOverlapping, wordsFound) = FindMatchingShapes.hasOverlappingWordsHorizontal(width: width, height: height, text: text, wordList: wordList)
        
        XCTAssertFalse(hasOverlapping)
        
    }

}
