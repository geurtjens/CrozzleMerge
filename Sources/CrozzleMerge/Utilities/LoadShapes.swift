//
//  File.swift
//  
//
//  Created by Michael Geurtjens on 6/1/2023.
//

import Foundation
public class LoadShapes {
    
    public static func Execute(filename: String) -> [ShapeModel] {

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(filename)

           
            //reading
            do {
                var text2 = try String(contentsOf: fileURL, encoding: .utf8)
                
                let array = text2.components(separatedBy: "\n")
                
                var shapes:[ShapeModel] = []
                for csv in array {
                    
                    var x = csv.replacingOccurrences(of: "[", with: "").replacingOccurrences(of:"]", with: "")
                    let shape = ShapeModel(csv:x)
                    shapes.append(shape)
                    x = ""
                }
                text2 = ""
                print("Ready")
                return shapes
                
            }
            catch {/* error handling here */}
        }
        return []
    }
}
