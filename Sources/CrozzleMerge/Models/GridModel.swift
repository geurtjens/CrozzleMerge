//
//  GridModel.swift
//  CrosswordExperiment
//
//  Created by Michael Geurtjens on 25/12/21.
//

import Foundation

class GridModel : Identifiable {
    let id : Int
    let year: Int
    let maxWidth : Int
    let maxHeight : Int
    let winningScore : Int
    let tags : [String]
    let winningWords : [String]
    let nonWinningWords : [String]
    let words:[String]
    
    init(gameId: Int, year: Int, maxWidth: Int, maxHeight: Int, winningScore: Int, tags: [String], winningWords: [String], nonWinningWords:[String], winningGame: [String] ) {
        self.id = gameId
        self.year = year
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.tags = tags
        self.winningWords = winningWords
        self.nonWinningWords = nonWinningWords
        self.words = [winningWords, nonWinningWords].flatMap{ $0 }
        self.winningScore = winningScore
    }
}

