//
//  Test_FindMatchingShapes.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_FindMatchingShapes: XCTestCase {

 

    func testExample() throws {
        let result = FindMatchingShapes.ExecuteAll(minScorePerWord: 26)
        print(result.count)
        print("Completed Successfully")
    }

   

    
}
