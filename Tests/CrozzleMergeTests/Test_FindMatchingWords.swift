//
//  Test_CrazyStuff.swift
//  
//
//  Created by Michael Geurtjens on 9/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_FindMatchingWords: XCTestCase {

    
    func test_CompatibleDirectionsSame_True() throws {
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let directionsAreCompatible = FindMatchingWords.CompatibleDirectionSame(placementsA: placementsA, placementsB: placementsB)

        XCTAssertTrue(directionsAreCompatible)
    }
    
    
    func test_CompatibleDirectionsSame_False() throws {
        /// We want to return false because the words placed are not all in the same direction.
        /// This is used once we have found matching words
        /// And we can eliminate that they cannot merge if the directions of the words are not the same
        
        
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: false)]

        let directionsAreCompatible = FindMatchingWords.CompatibleDirectionSame(placementsA: placementsA, placementsB: placementsB)

        XCTAssertFalse(directionsAreCompatible)
    }
    
    
    func test_CompatibleDirectionsOpposite_True() throws {
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: false)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: false),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let directionsAreCompatible = FindMatchingWords.CompatibleDirectionOpposite(placementsA: placementsA, placementsB: placementsB)

        XCTAssertTrue(directionsAreCompatible)
    }
    
    
    func test_CompatibleDirectionsOpposite_False() throws {
        /// We want to return false because the words placed are not all in the same direction.
        /// This is used once we have found matching words
        /// And we can eliminate that they cannot merge if the directions of the words are not the same
        
        
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: false)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: false),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: false)]

        let directionsAreCompatible = FindMatchingWords.CompatibleDirectionOpposite(placementsA: placementsA, placementsB: placementsB)

        XCTAssertFalse(directionsAreCompatible)
    }
    
    func test_CompatibleDirections_True() throws {
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let directionsAreCompatible = FindMatchingWords.CompatibleDirections(placementsA: placementsA, placementsB: placementsB)

        XCTAssertTrue(directionsAreCompatible)
    }
    
    func test_CompatibleDirections_False() throws {
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: false)]

        let directionsAreCompatible = FindMatchingWords.CompatibleDirections(placementsA: placementsA, placementsB: placementsB)

        // You can see that the second word of second shape is going in a different direction to second word of first shape
        XCTAssertFalse(directionsAreCompatible)
    }
    
    func test_AreCommonWordsInSameDirection_True() throws {
        // We are only checking the first one because we have already established prior to this
        // if all words are going in same direction, this is just a quick check
        // ITS NOT A GOOD STAND ALONE CHECK we need others
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]
        
        XCTAssertTrue(FindMatchingWords.AreCommonWordsInSameDirection(placementsA: placementsA, placementsB: placementsB))
    }
    
    func test_AreCommonWordsInSameDirection_False() throws {
        // We are only checking the first one because we have already established prior to this
        // if all words are going in same direction, this is just a quick check
        // ITS NOT A GOOD STAND ALONE CHECK we need others
        let placementsA = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: true),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]

        let placementsB = [
            PlacementModel(id: 25, x: 0, y: 1, isHorizontal: false),
            PlacementModel(id: 6, x: 3, y: 4, isHorizontal: true)]
        
        XCTAssertFalse(FindMatchingWords.AreCommonWordsInSameDirection(placementsA: placementsA, placementsB: placementsB))
    }
    
    
    
    
    func test_CompatibleDirections_SameDirection_True() throws {
        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: true),
            PlacementModel(id:1,x:3,y:4,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: true),
            PlacementModel(id:1,x:7,y:7,isHorizontal: false)
        ]
        
        // These have compatible directions because true in one is true in another and false in one is false in another
        XCTAssertTrue(FindMatchingWords.CompatibleDirectionSame(placementsA: placementsA, placementsB: placementsB))
        
        let result = FindMatchingWords.CompatibleDirections(placementsA: placementsA, placementsB: placementsB)
        
        XCTAssertTrue(result)
        
        //
    }
    func test_CompatibleDirections_OppositeDirection_True() throws {
        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: true),
            PlacementModel(id:1,x:3,y:4,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: false),
            PlacementModel(id:1,x:7,y:7,isHorizontal: true)
        ]
        
        // These have compatible directions because true in one is false in another and false in one is true in another for all matching pairs
        
        XCTAssertTrue(FindMatchingWords.CompatibleDirectionOpposite(placementsA: placementsA, placementsB: placementsB))
        
        // And so if its compatible in opposite direction then overall its compatible
        XCTAssertTrue(FindMatchingWords.CompatibleDirections(placementsA: placementsA, placementsB: placementsB))
    }
    /// We have common words and so are they in exactly the same direction from one shape to another
    /// This should return true as they are in same direction
    func test_IsSameDirection_True() throws {

        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: true),
            PlacementModel(id:1,x:3,y:4,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: true),
            PlacementModel(id:1,x:7,y:7,isHorizontal: false)
        ]
        
        let result = FindMatchingWords.AreCommonWordsInSameDirection(placementsA: placementsA, placementsB: placementsB)
        
        XCTAssertTrue(result)
    }

    /// We have common words and so are they in exactly the same direction from one shape to another
    /// This should return false as they are not in same direction
    func test_IsSameDirection_False() throws {

        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: false),
            PlacementModel(id:1,x:3,y:4,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: true),
            PlacementModel(id:1,x:7,y:7,isHorizontal: false)
        ]
        
        let result = FindMatchingWords.AreCommonWordsInSameDirection(placementsA: placementsA, placementsB: placementsB)
        
        XCTAssertFalse(result)
    }
    
    func test_FindCommonValidWords() throws {
        let placementsA = [
            PlacementModel(id:0,x:1,y:2,isHorizontal: true),
            PlacementModel(id:6,x:3,y:4,isHorizontal: false),
            PlacementModel(id:1,x:5,y:6,isHorizontal: true),
            PlacementModel(id:8,x:7,y:8,isHorizontal: false)
        ]
        
        let placementsB = [
            PlacementModel(id:0,x:5,y:6,isHorizontal: true),
            PlacementModel(id:1,x:7,y:7,isHorizontal: true),
            PlacementModel(id:9,x:8,y:9,isHorizontal: true),
            PlacementModel(id:18,x:10,y:11,isHorizontal: false)
        ]
        
        let (a,b,sameDirection) = FindMatchingWords.FindCommonValidWords(placementsA: placementsA, placementsB: placementsB)
        
        XCTAssertEqual(a.count, 2)
        XCTAssertEqual(b.count, 2)
        XCTAssertEqual(a[0].id, b[0].id)
        XCTAssertEqual(a[1].id, b[1].id)
        XCTAssertTrue(sameDirection)
    }
}
