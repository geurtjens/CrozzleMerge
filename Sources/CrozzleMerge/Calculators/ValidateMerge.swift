//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 7/1/2023.
//

import Foundation
public class ValidateMerge {
    
    
    public static func Execute(shapeA: ShapeModel, shapeB: ShapeModel, rotatedShapeB: ShapeModel, scoreMin: UInt16, widthMax: UInt8, heightMax: UInt8, wordList: [String]) -> (Bool, String, UInt16, UInt8, UInt8, [PlacementModel]) {
        // Returns a list of placements that are in the same order as we found them
        let (placementsA, placementsB, sameOrientation) = FindMatchingWords.FindCommonValidWords(placementsA: shapeA.p, placementsB: shapeB.p)
        // The opposite orientation ones are not working
        if (placementsA.count == 0) {
            // we could not find compatible common words
            return (false,"",0,0,0,[])
        }
        
        if sameOrientation == false {
            // if we find the orientation is wrong then use the rotated shape and do it again
            return Execute(shapeA: shapeA, shapeB: rotatedShapeB, rotatedShapeB: shapeB, scoreMin: scoreMin, widthMax: widthMax, heightMax:heightMax, wordList: wordList)
        }
        
        
            
        if DistanceSameOrientation(placementsA: placementsA, placementsB: placementsB) == false {
            return (false,"",0,0,0,[])
        }

        let width = widthSameOrientation(widthA: shapeA.w, widthB: shapeB.w, xA: placementsA[0].x, xB: placementsB[0].x)
        let height = heightSameOrientation(heightA: shapeA.h, heightB: shapeB.h, yA: placementsA[0].y, yB: placementsB[0].y)
        
        if ((width <= widthMax && height <= heightMax) || (height <= widthMax && width <= heightMax)) == false {
            // The new height or width is too large
            return (false,"",0,width,height,[])
        }
        
        let placementsCommonExtractedB = extractCommonPlacements(placements: shapeB.p, placementsToExtract: placementsB)
        
        let placements = alignPlacements(commonWordA: placementsA[0], commonWordB: placementsB[0], placementsA: shapeA.p, placementsB: placementsCommonExtractedB)
        
        let (success, shapeText, score) = DrawShape.draw(placements: placements, width: width, height: height, wordList: wordList)
        
        
        if score < scoreMin {
            return (false, shapeText, score, width, height, placements)
        }
        return (success, shapeText, score, width, height, placements)
            
        
        
//        else if sameOrientation == false {
//            return (false, "",0,0,0)
//            // We have yet to prove that this reversing thing works, lets test it later
//            if DistanceDifferentOrientation(placementsA: placementsA, placementsB: placementsB) == false {
//                return false
//            }
//            return false
//        }
        //return (false,"",0,0,0,[])
    }
    
    
    public static func extractCommonPlacements(placements: [PlacementModel], placementsToExtract: [PlacementModel]) -> [PlacementModel] {
        
        let wordsToExtract: [UInt8] = placementsToExtract.map { $0.id }
        
        var result:[PlacementModel] = []
        for placement in placements {
            if wordsToExtract.contains(placement.id) == false {
                result.append(placement)
            }
        }
        return result
    }
    
    public static func placementOffsetX(placements:[PlacementModel], offsetX: UInt8) -> [PlacementModel] {
        var result: [PlacementModel] = []
        for placement in placements {
            let offsetPlacement = PlacementModel(id: placement.id, x: placement.x + offsetX, y: placement.y, isHorizontal: placement.isHorizontal)
            result.append(offsetPlacement)
        }
        return result
    }
    
    public static func placementOffsetY(placements:[PlacementModel], offsetY: UInt8) -> [PlacementModel] {
        var result: [PlacementModel] = []
        for placement in placements {
            let offsetPlacement = PlacementModel(id: placement.id, x: placement.x, y: placement.y + offsetY, isHorizontal: placement.isHorizontal)
            result.append(offsetPlacement)
        }
        return result
    }
    
    public static func alignPlacements( commonWordA: PlacementModel, commonWordB: PlacementModel, placementsA: [PlacementModel], placementsB: [PlacementModel]) -> [PlacementModel] {
            
        var finalPlacementA:[PlacementModel] = placementsA
        var finalPlacementB:[PlacementModel] = placementsB
        
        if commonWordB.x < commonWordA.x {
            let diff: UInt8 = commonWordA.x - commonWordB.x
            finalPlacementB = placementOffsetX(placements: finalPlacementB, offsetX: diff)
            
        } else if commonWordA.x < commonWordB.x {
            let diff: UInt8 = commonWordB.x - commonWordA.x
            finalPlacementA = placementOffsetX(placements:finalPlacementA, offsetX: diff)
        }
        
        if commonWordB.y < commonWordA.y {
            let diff: UInt8 = commonWordA.y - commonWordB.y
            finalPlacementB = placementOffsetY(placements: finalPlacementB, offsetY: diff)
            
        } else if commonWordA.y < commonWordB.y {
            let diff: UInt8 = commonWordB.y - commonWordA.y
            finalPlacementA = placementOffsetY(placements:finalPlacementA, offsetY: diff)
        }
        
        let placements = finalPlacementA + finalPlacementB
        return placements
    }
    
    
    public static func drawSameOrientation(
        width: UInt8,
        height: UInt8,
        placements: [PlacementModel],
        words: [String],
        shapeA: ShapeModel,
        shapeB: ShapeModel) -> (Bool, String, UInt16) {

                
       

        // So placements now contains all the words that I need
        
        
        // We are going to draw all the shapes in A and only those in b that are not already included
        // If it doesnt work then we return false and if it does work we return True
        // and if true we return the actual combined one
        
        let (success, shapeText, score) = DrawShape.draw(placements: placements, width: width, height: height, wordList: words)
        
        
        return (success, shapeText, score)
    }
    
    public static func widthSameOrientation(widthA: UInt8, widthB: UInt8, xA: UInt8, xB: UInt8) -> UInt8 {
        // Lets just choose the first one
        
        
        // The width should be width of shapeA plus the overlap and width of shapeB
        // The height should be height of shapeA plus the overlap and height of shapeB
        let largestLeft = max(xA, xB)
        let largestRight = max(widthA - xA, widthB - xB)
        let width = largestLeft + largestRight
        return width

    }
    
    public static func heightSameOrientation(heightA: UInt8, heightB: UInt8, yA: UInt8, yB: UInt8) -> UInt8 {
        // The height should be height of shapeA plus the overlap and height of shapeB
        let largestUp = max(yA, yB)
        let largestDown = max(heightA - yA, heightB - yB)
        let height = largestUp + largestDown
        return height

    }
    
    
    
    
    
    
    
    
    
    /// Tells us if the distances between the words are the same for two shapes
    /// We assume the placements are common words between two shapes
    /// - Parameters:
    ///   - placementsA: common words that are in shape A and also in shape B
    ///   - placementsB: common words that are in shape B and also in shape A
    /// - Returns: True if the common words are of the same distances from each other
    public static func DistanceSameOrientation(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {
        // We assume what is given to us is the common placements for both shapes
        // We assume the isHorizontal is the same for both sets of placements also
        let distanceA = CheckDistances(placements: placementsA)
        let distanceB = CheckDistances(placements: placementsB)
        
        for i in 0..<distanceA.count {
            let itemA = distanceA[i]
            let itemB = distanceB[i]
            if itemA.0 != itemB.0 || itemA.1 != itemB.1 {
                return false
            }
        }
        return true
    }
    
    /// Tells us if the distances between the words are the same for two shapes
    /// We assume the placements are common words between two shapes
    /// - Parameters:
    ///   - placementsA: common words that are in shape A and also in shape B
    ///   - placementsB: common words that are in shape B and also in shape A
    /// - Returns: True if the common words are of the same distances from each other
    public static func DistanceDifferentOrientation(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {
        // We assume what is given to us is the common placements for both shapes
        // We assume the isHorizontal is the same for both sets of placements also
        let distanceA = CheckDistances(placements: placementsA)
        let distanceB = CheckDistances(placements: placementsB)
        
        for i in 0..<distanceA.count {
            let itemA = distanceA[i]
            let itemB = distanceB[i]
            if itemA.0 != itemB.1 || itemA.1 != itemB.0 {
                return false
            }
        }
        return true
    }
    
    public static func CheckDistances(placements: [PlacementModel]) -> [(Int, Int)] {
        if placements.count < 2 {
            return []
        }
        
        // First we sort so we are comparing the same words
       
        let sorted = placements.sorted { $0.id < $1.id}
        
        let comparison = sorted[0]
        
        var result: [(Int,Int)] = []
        
        for i in 1..<placements.count {
            let placement = placements[i]
            let xDiff: Int = Int(comparison.x) - Int(placement.x)
            let yDiff: Int = Int(comparison.y) - Int(placement.y)
            result.append((xDiff, yDiff))
        }
        return result
    }
}
