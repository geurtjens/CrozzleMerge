//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import Foundation
public class LoadWords {
    public static func Execute(filename: String) -> [String] {

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(filename)

            do {
                let contents = try String(contentsOf: fileURL, encoding: .utf8)
                
                let words = contents.components(separatedBy: "\n")
                
                return words
                
            }
            catch {
                /* error handling here */
                print("cannot load words in \(filename)")
            }
        }
        return []
    }
}
