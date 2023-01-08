//
//  File.swift
//
//
//  Created by Michael Geurtjens on 16/12/2022.
//

import Foundation
/// Converts the shape into a text representation of the shape as it would be rendered into a grid
public class DrawShape {
    
    
    /// Render a shape in its own text string.
    /// - Parameters:
    ///   - shape: shape has been calculated by a previous process that was responsible for making it a valid shape
    ///   - wordList: an array of words used when creating the shape, important for knowing the word in each position
    /// - Returns: Creates a string which accurately represents the shape as it could be rendered in a grid apart from having the end of line characters in it.
    public static func draw(shape: ShapeModel, wordList:[String]) -> String {
        
        var result = getInitialShape(width: shape.w, height: shape.h)
        // Then we place each character and convert the array into a string somehow
        
        let horizontalPlacements = shape.p.filter { $0.isHorizontal == true}
        let verticalPlacements = shape.p.filter {$0.isHorizontal == false}
        for placement in horizontalPlacements {
            
            let startingLocation = getLocation(
                x: placement.x,
                y: placement.y,
                width: shape.w)
            
            
            result[startingLocation] = "."
            
            let word = wordList[Int(placement.id)]
            
            for i in 0..<word.count {
                let location = startingLocation + i + 1
                result[location] = word[i]
            }
            result[startingLocation + word.count + 1] = "."
        }
        for placement in verticalPlacements {
            
            let startingLocation = getLocation(
                x: placement.x,
                y: placement.y,
                width: shape.w)
            
            result[startingLocation] = "."
            
            let word = wordList[Int(placement.id)]
            for i in 0..<word.count {
                let location = getLocation(
                    x: placement.x,
                    y: placement.y + UInt8(i) + 1,
                    width: shape.w)
                result[location] = word[i]
            
                
            }
            let lastLocation = getLocation(
                x: placement.x,
                y: placement.y + UInt8(word.count + 1),
                width: shape.w)
            
            result[lastLocation] = "."
        }

        return String(result)
    }
    
    public static func rotatePlacements(placements: [PlacementModel]) -> [PlacementModel] {
        var result: [PlacementModel] = []
        for placement in placements {
            let rotated = PlacementModel(id: placement.id, x: placement.y, y: placement.x, isHorizontal: !placement.isHorizontal)
            result.append(rotated)
        }
        return result
    }
    
    
    
    public static func draw(placements: [PlacementModel], width: UInt8, height: UInt8, wordList:[String]) -> (Bool,String,UInt16) {
        
        var score = 0
        var result = getInitialShape(width: width, height: height)
        // Then we place each character and convert the array into a string somehow
        
        let horizontalPlacements = placements.filter { $0.isHorizontal == true}
        let verticalPlacements = placements.filter {$0.isHorizontal == false}
        for placement in horizontalPlacements {
            
            let startingLocation = getLocation(
                x: placement.x,
                y: placement.y,
                width: width)
            
            let currentLetter = result[startingLocation]
            
            if currentLetter != "." && currentLetter != " " {
                result[startingLocation] = "#"
                return (false, String(result), 0)
            }
            
            result[startingLocation] = "."
            
            let word = wordList[Int(placement.id)]
            
            for i in 0..<word.count {
                let location = startingLocation + i + 1
                
                let currentLetter = result[location]
                
                if currentLetter != " " && currentLetter != word[i] {
                    result[location] = "#"
                    return (false, String(result), 0)
                }
                if currentLetter == word[i] {
                    score += ScoreCalculator.score(forLetter: currentLetter)
                }
                result[location] = word[i]
            }
            
            let lastLetter = result[startingLocation + word.count + 1]
            
            if lastLetter != " " && lastLetter != "." {
                result[startingLocation + word.count + 1] = "#"
                return (false, String(result),0)
            }
            
            result[startingLocation + word.count + 1] = "."
        }
        for placement in verticalPlacements {
            
            let startingLocation = getLocation(
                x: placement.x,
                y: placement.y,
                width: width)
            
            let startingLetter = result[startingLocation]
            if startingLetter != " " && startingLetter != "." {
                result[startingLocation] = "#"
                return (false, String(result),0)
            }
            
            result[startingLocation] = "."
            
            let word = wordList[Int(placement.id)]
            for i in 0..<word.count {
                let location = getLocation(
                    x: placement.x,
                    y: placement.y + UInt8(i) + 1,
                    width: width)

                let currentLetter = result[location]
                if currentLetter != " " && currentLetter != word[i] {
                    result[location] = word[i]
                    return (false,String(result),0)
                }

                if currentLetter == word[i] {
                    score += ScoreCalculator.score(forLetter: currentLetter)
                } else {
                    result[location] = word[i]
                }
                
            }
            let lastLocation = getLocation(
                x: placement.x,
                y: placement.y + UInt8(word.count + 1),
                width: width)
            
            let lastLetter = result[lastLocation]
            
            if lastLetter != " " && lastLetter != "." {
                result[lastLocation] = "#"
                return (false, String(result),0)
            } else {
                result[lastLocation] = "."
            }
            
        }

        return (true, String(result), UInt16(score + placements.count * 10))
    }
    
    
    
    
    
    
    public static func flatDraw(text: String) -> String {
        return ("\"" + text + "\"").replacingOccurrences(of: "\n", with: "^")
    }
    
    /// Create an array that is the right size to hold the shape and place end of line characters where they need to be
    /// - Parameters:
    ///   - width: width of shape
    ///   - height: height of shape
    /// - Returns: An array of characters which contains end of line characters and correct size
    public static func getInitialShape(width: UInt8, height: UInt8) -> [Character] {
        let size = sizeOfShape(width: width, height: height)
        
        var result: [Character] = Array(repeating: " ", count: size)
        
        var position = 0
        for y in 0..<height-1 {
            if y == 0 {
                position += Int(width)
            } else {
                position += Int(width) + 1
            }
            result[position] = "\n"
        }
        return result
    }
    
    
    /// Calculate the character location.  x,y assumes a 2d datastructure but our data structure is an array of characters
    /// - Parameters:
    ///   - x: x position of the letter to be placed into the grid, given the grid is a text string
    ///   - y: y position of the letter we want to place into the grid, given the grid is a text string
    ///   - width: the known width is needed to calculate where the letter should go
    /// - Returns: Location within the string that we must place our letter
    public static func getLocation(x: UInt8, y: UInt8, width: UInt8) -> Int {
        return (Int(width) + 1) * Int(y) + Int(x)
    }
    
    
    /// Determines how many bytes are required to contain the shape
    /// - Parameters:
    ///   - width: The width of the shape that was calculated when the shape was created
    ///   - height: The height of the shape that was calculated when the shape was created
    /// - Returns: size of the shape if it is rendered
    public static func sizeOfShape(width: UInt8, height: UInt8) -> Int {
        let size = Int(width+1) * Int(height) - 1
        return size
    }
}
