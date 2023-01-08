//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 7/1/2023.
//

import Foundation
public class ValidateMerge {
    
    
    public static func Execute(shapeA: ShapeModel, shapeB: ShapeModel, scoreMin: UInt16, widthMax: UInt8, heightMax: UInt8, wordList: [String]) -> (Bool, String, UInt16, UInt8, UInt8) {
        // Returns a list of placements that are in the same order as we found them
        let (placementsA, placementsB) = FindCommonWords(placementsA: shapeA.p, placementsB: shapeB.p)
        
        // if the words that are common are not in same orientation then it will never work
        if CompatibleDirections(placementsA: placementsA, placementsB: placementsB) == false {
            return (false,"",0,0,0)
        }
        
        let sameOrientation = AreCommonWordsInSameDirection(placementsA: placementsA, placementsB: placementsB)
        
        if sameOrientation == true {
            
            if DistanceSameOrientation(placementsA: placementsA, placementsB: placementsB) == false {
                return (false,"",0,0,0)
            }
            
            

            let width = widthSameOrientation(widthA: shapeA.w, widthB: shapeB.w, xA: placementsA[0].x, xB: placementsB[0].x)
            let height = heightSameOrientation(heightA: shapeA.h, heightB: shapeB.h, yA: placementsA[0].y, yB: placementsB[0].y)
            
            if ((width <= widthMax && height <= heightMax) || (height <= widthMax && width <= heightMax)) == false {
                // The new height or width is too large
                return (false,"",0,width,height)
            }
            
            
            
            // Need to figure out how to do the offset thing to know where we should be placed.
            // If offsetX is positive then choose offsets of x in the A direction else the B direction
            // If offsetY is position then choose offsets of y in the A direction else the B direction

            let placementsCommonExtractedB = extractCommonPlacements(placements: shapeB.p, placementsToExtract: placementsB)
            
            
            let (success, shapeText, score) = drawSameOrientation(
                width: width,
                height: height,
                commonWordA: placementsA[0],
                commonWordB: placementsB[0],
                placementsA: shapeA.p,
                placementsB: placementsCommonExtractedB,
                words: wordList,
                shapeA: shapeA,
                shapeB: shapeB)
            
            if score < scoreMin {
                return (false, shapeText, score, width, height)
            }
            return (success, shapeText, score, width, height)
            
        }
//        else if sameOrientation == false {
//            return (false, "",0,0,0)
//            // We have yet to prove that this reversing thing works, lets test it later
//            if DistanceDifferentOrientation(placementsA: placementsA, placementsB: placementsB) == false {
//                return false
//            }
//            return false
//        }
        return (false,"",0,0,0)
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
    
    public static func drawSameOrientation(
        width: UInt8,
        height: UInt8,
        commonWordA: PlacementModel,
        commonWordB: PlacementModel,
        placementsA: [PlacementModel],
        placementsB: [PlacementModel],
        words: [String],
        shapeA: ShapeModel,
        shapeB: ShapeModel) -> (Bool, String, UInt16) {

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
    
    /// Are the common words in ShapeA the same orientation as common words in ShapeB
    /// That is if all shapeA is horizontal and all shapeB is also isHorizontal
    /// - Parameters:
    ///   - placementsA: common words in the order we found them
    ///   - placementsB: common words in the order we found them
    /// - Returns: true if the common words are in the same orientation
    public static func AreCommonWordsInSameDirection(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {
        return placementsA[0].isHorizontal == placementsB[0].isHorizontal
    }
    
    
    public static func CompatibleDirectionSame(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {
        
        // We assume the lists are the same size
        
        for i in 1..<placementsA.count {
            if placementsA[i].isHorizontal != placementsB[i].isHorizontal {
                return false
            }
        }
        return true
    }
    
    public static func CompatibleDirectionOpposite(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {
        
        // We assume the lists are the same size
        
        for i in 1..<placementsA.count {
            if placementsA[i].isHorizontal == placementsB[i].isHorizontal {
                return false
            }
        }
        return true
    }
    
    public static func CompatibleDirections(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {

        // first we see if they are compatible based on them all being in same direction
        let isSameDirectionCompatible = CompatibleDirectionSame(placementsA: placementsA, placementsB: placementsB)
        
        if isSameDirectionCompatible == true {
            return true
        }
        
        let isOppositeDirectionCompatible = CompatibleDirectionOpposite(placementsA: placementsA, placementsB: placementsB)
        
        if isOppositeDirectionCompatible == true {
            return true
        } else {
            // This means that these two shapes cannot be merged together as their common words are neither uniformly the same or uniformly opposite
            return false
        }
    }
    
    public static func FindCommonWords(placementsA: [PlacementModel], placementsB: [
        PlacementModel]) -> ([PlacementModel],[PlacementModel]) {
        var commonPlacementsA: [PlacementModel] = []
        var commonPlacementsB: [PlacementModel] = []
        
        for i in 0..<placementsA.count {
            for j in 0..<placementsB.count {
                if placementsA[i].id == placementsB[j].id {
                    commonPlacementsA.append(placementsA[i])
                    commonPlacementsB.append(placementsB[j])
                }
            }
        }
        return (commonPlacementsA, commonPlacementsB)
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
