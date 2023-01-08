//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 17/12/2022.
//

import Foundation
/// Contains all score calculations used in the crozzle calculation.
public class ScoreCalculator {
    
    /// Scoring an edge includes two words so its 20 plus the interlocking letter score
    /// - Parameter letter: A letter from "A" to "Z" always in capitals
    /// - Returns: The score from connecting the two words in the edge
    public static func score(forEdgeWithLetter letter: Character) -> Int {
        return score(forLetter: letter) + 20
    }
    
    public static func score(word: String) -> Int {
        var result = 0
        for letter in word {
            result += score(forLetter: letter)
        }
        return result
    }
    
    /// Score of one interlocked letter.  Always pass in a capital letter.
    /// - Parameter letter: A letter from "A" to "Z" which was interlocked
    /// - Returns: The score for interlocking that letter
    public static func score(forLetter letter: Character) -> Int {
        switch letter {
        case "A", "B", "C", "D", "E", "F":
            return 2
        case "G","H","I","J","K","L":
            return 4
        case "M","N","O","P","Q","R":
            return 8
        case "S","T","U","V","W","X":
            return 16
        case "Y":
            return 32
        case "Z":
            return 64
        default:
            return 0
        }
    }
}
