//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 4/12/2022.
//

import Foundation
extension StringProtocol {
subscript(offset: Int) -> Character {
    self[index(startIndex, offsetBy: offset)]
  }
}
