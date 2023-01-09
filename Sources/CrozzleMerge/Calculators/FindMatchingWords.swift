//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 10/1/2023.
//

import Foundation
public class FindMatchingWords {
    
    public static func FindCommonValidWords(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> ([PlacementModel],[PlacementModel], Bool) {
            
        let (commonPlacementsA, commonPlacementsB) = FindCommonWords2(placementsA: placementsA, placementsB: placementsB)
            
        if commonPlacementsA.count == placementsA.count || commonPlacementsB.count == placementsB.count {
            // one word is not a subset of another word
            return ([], [], false)
        }
        
        // if the words that are common are not in same orientation then it will never work
        if CompatibleDirections(placementsA: commonPlacementsA, placementsB: commonPlacementsB) == false {
            return ([],[], false)
        }
        
        let sameOrientation = AreCommonWordsInSameDirection(placementsA: placementsA, placementsB: placementsB)
        
            
            
            
        return (commonPlacementsA, commonPlacementsB, sameOrientation)
    }
    
    public static func FindCommonWords2(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> ([PlacementModel],[PlacementModel]) {
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
        return (commonPlacementsA,commonPlacementsB)
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
        
        for i in 0..<placementsA.count {
            if placementsA[i].isHorizontal != placementsB[i].isHorizontal {
                return false
            }
        }
        return true
    }
    
    public static func CompatibleDirectionOpposite(placementsA: [PlacementModel], placementsB: [PlacementModel]) -> Bool {
        
        // We assume the lists are the same size
        
        for i in 0..<placementsA.count {
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
}
