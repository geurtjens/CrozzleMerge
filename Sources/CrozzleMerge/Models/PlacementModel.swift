//
//  PlacementModel.swift
//
//
//  Created by Michael Geurtjens on 17/12/2022.
//

import Foundation
/// Use this to place a word into the shape
public struct PlacementModel {
    /// The location of the word in the array of words that was provided when the shape was calculated.  Each word has an id and they must all be different and I think sorted in increasing order.  Based on the word we also have the x, y and isHorizontal
    public let id: UInt8
    
    /// x location, the starting location of each word in the shape, it is where the leading blocking character will appear
    public let x: UInt8
    
    /// y location, the starting location vertically of each word in the shape, it is where the leading blocking character will appea
    public let y: UInt8
    
    /// If true then we place this word horizontally and if false the word will be placed vertically.
    public let isHorizontal: Bool

}
