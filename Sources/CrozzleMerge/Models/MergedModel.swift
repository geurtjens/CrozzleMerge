//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 11/1/2023.
//

import Foundation
public struct MergedModel {
    /// Shape origin
    public let shapeId: Int

    /// This is the shape and also the score that it produces as a dictionary
    public let compatibleShapes: [MergedItemModel]

}
