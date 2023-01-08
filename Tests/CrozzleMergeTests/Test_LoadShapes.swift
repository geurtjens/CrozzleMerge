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

  

}
