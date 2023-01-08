//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import Foundation
public class LoadWordToShapeIndex {
    public static func Execute(filename: String) -> [[Int]] {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(filename)

            do {
                var contents = try String(contentsOf: fileURL, encoding: .utf8)
                
                let lines = contents.components(separatedBy: "\n")
                
                var result:[[Int]] = []
                for line in lines {
                    let items = line.components(separatedBy:",")
                    var wordIndex:[Int] = []
                    for i in 0..<items.count {
                        let integerValue = Int(items[i])!
                        wordIndex.append(integerValue)
                    }
                    if wordIndex.count > 0 {
                        result.append(wordIndex)
                    }
                    
                    
                }
                contents = ""
                
                return result
            }
            catch {/* error handling here */}
        }
        return []
    }
}
