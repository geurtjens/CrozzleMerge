//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 9/1/2023.
//

import Foundation
public class TextToShapeCalculator {
    
    
    public static func TextToCode(shapeText: String, wordList: [String]) -> String {
        let shape = textToShape(shapeText:shapeText, wordList: wordList)
        let code = shapeToCode(shape:shape)
        return code
    }
    
    
    public static func textToShape(shapeText: String, wordList:[String]) -> ShapeModel {
        
        let grid = shapeText.split(separator: "\n")

        let width = grid[0].count

        let height = grid.count

        let (horizontalPlacements, horizontalWords) = getHorizontalPlacements(grid: grid, width: width, height: height, wordList: wordList)
        
        print("//\(horizontalWords)")
        
        let (verticalPlacements, verticalWords) = getVerticalPlacements(grid: grid, width: width, height: height, wordList: wordList)
        print("//\(verticalWords)")
        
        let placements = horizontalPlacements + verticalPlacements
        
        let shape = ShapeModel(s: 0, w: UInt8(width), h: UInt8(height), p: placements)
        
        return shape
        
    }

    public static func shapeToCode(shape: ShapeModel) -> String {
        let placementSrc = placementsToCode(placements: shape.p)
        
        let result = placementSrc + "\nlet shape = ShapeModel(s: \(shape.s), w: \(shape.w), h: \(shape.h), p: placements)\n"
        
        return result
        
    }
    
    public static func placementsToCode(placements: [PlacementModel]) -> String {
        var result = ""
        for placement in placements {
            
            if result != "" {
                result += ","
            }
            
            var horizontal = "true"
            if placement.isHorizontal == false {
                horizontal = "false"
            }
            
            result += "PlacementModel(id: \(placement.id), x: \(placement.x), y: \(placement.y), isHorizontal: \(horizontal))"
        }
        
        result = "let placements = [" + result + "]\n"
        return result
    }
    
    public static func getHorizontalPlacements(grid:[String.SubSequence], width: Int, height: Int, wordList: [String]) -> ([PlacementModel],[String]) {
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        var startX = 0
        var startY = 0
        var currentWord = ""

        var words:[String] = []
        
        var xy:[(UInt8,UInt8)] = []
        
        
        for j in 0..<height {
            for i in 0..<width {
                // We go along the horizontal line looking for words to start
                let letter = grid[j][i]
                
                switch letter {
                case ".":
                    if currentWord.count > 1 {
                        words.append(currentWord)
                        xy.append((UInt8(startX), UInt8(startY)))
                        currentWord = ""
                    } else {
                        startX = i
                        startY = j
                        currentWord = ""
                    }
                    
                case " ":
                    currentWord = ""
                default:
                    if alphabet.contains(letter) {
                        currentWord += String(letter)
                    }
                }
            }
        }
        
        let wordId = getWordPositions(words: words, wordList: wordList)
        
        var placements:[PlacementModel] = []
        for i in 0..<wordId.count {
            let id = wordId[i]
            let (x,y) = xy[i]

            placements.append(PlacementModel(id: id, x: x, y: y, isHorizontal: true))
        }
        return (placements, words)
    }
    
    
    public static func getVerticalPlacements(grid:[String.SubSequence], width: Int, height: Int, wordList: [String]) -> ([PlacementModel],[String]) {
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        var startX = 0
        var startY = 0
        var currentWord = ""

        var words:[String] = []
        
        var xy:[(UInt8,UInt8)] = []
        
        
        for i in 0..<width {
            for j in 0..<height {
                // We go along the horizontal line looking for words to start
                let letter = grid[j][i]
                
                switch letter {
                case ".":
                    if currentWord.count > 1 {
                        words.append(currentWord)
                        xy.append((UInt8(startX), UInt8(startY)))
                        currentWord = ""
                    } else {
                        startX = i
                        startY = j
                        currentWord = ""
                    }
                    
                case " ":
                    currentWord = ""
                default:
                    if alphabet.contains(letter) {
                        currentWord += String(letter)
                    }
                }
            }
        }
        
        let wordId = getWordPositions(words: words, wordList: wordList)
        
        var placements:[PlacementModel] = []
        for i in 0..<wordId.count {
            let id = wordId[i]
            let (x,y) = xy[i]

            placements.append(PlacementModel(id: id, x: x, y: y, isHorizontal: false))
        }
        return (placements,words)
    }
    
    
    
    
    
    
    public static func getWordPositions(words:[String], wordList: [String]) -> [UInt8] {
        var result: [UInt8] = []
        for word in words {
            let id = wordPosition(word: word, wordList: wordList)
            
            if id >= 0 {
                result.append(UInt8(id))
            }
        }
        return result
    }
    
    public static func wordPosition(word: String, wordList: [String]) -> Int {
        for i in 0..<wordList.count {
            if word == wordList[i] {
                return i
            }
        }
        return -1
    }
    
}
