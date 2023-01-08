//
//  Test_LoadIndex.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import XCTest
@testable import CrozzleMerge
final class Test_LoadWordToShapeIndex: XCTestCase {

    /// Load a shapeIndex which is an index of all shapes that share a particular word.  Each index is based on the word position in the list that you provided originally.
    /// So we can see just how many occurances in the various shapes that the word appears within
    func test_CheckFor8612_WordsInShapes() throws {
        let result = LoadWordToShapeIndex.Execute(filename: "8612_ShapeIndex.csv")
        
        XCTAssertEqual(result.count, 91)
        XCTAssertEqual(result[0].count, 104020)
        XCTAssertEqual(result[1].count, 125932)
        XCTAssertEqual(result[2].count, 78236)
        XCTAssertEqual(result[3].count, 32618)
        XCTAssertEqual(result[4].count, 237385)
        XCTAssertEqual(result[5].count, 105954)
        XCTAssertEqual(result[6].count, 268716)
        XCTAssertEqual(result[7].count, 64282)
        XCTAssertEqual(result[8].count, 163006)
        XCTAssertEqual(result[9].count, 94815)
        XCTAssertEqual(result[10].count, 168209)
        XCTAssertEqual(result[11].count, 162157)
        XCTAssertEqual(result[12].count, 129869)
        XCTAssertEqual(result[13].count, 99262)
        XCTAssertEqual(result[14].count, 124684)
        XCTAssertEqual(result[15].count, 127801)
        XCTAssertEqual(result[16].count, 161521)
        XCTAssertEqual(result[17].count, 125390)
        XCTAssertEqual(result[18].count, 163106)
        XCTAssertEqual(result[19].count, 78015)
        XCTAssertEqual(result[20].count, 199327)
        XCTAssertEqual(result[21].count, 101838)
        XCTAssertEqual(result[22].count, 104721)
        XCTAssertEqual(result[23].count, 157891)
        XCTAssertEqual(result[24].count, 116999)
        XCTAssertEqual(result[25].count, 132476)
        XCTAssertEqual(result[26].count, 191324)
        XCTAssertEqual(result[27].count, 157927)
        XCTAssertEqual(result[28].count, 151131)
        XCTAssertEqual(result[29].count, 238022)
        XCTAssertEqual(result[30].count, 351577)
        XCTAssertEqual(result[31].count, 128166)
        XCTAssertEqual(result[32].count, 183340)
        XCTAssertEqual(result[33].count, 189017)
        XCTAssertEqual(result[34].count, 239891)
        XCTAssertEqual(result[35].count, 325103)
        XCTAssertEqual(result[36].count, 118665)
        XCTAssertEqual(result[37].count, 249388)
        XCTAssertEqual(result[38].count, 253390)
        XCTAssertEqual(result[39].count, 278501)
        XCTAssertEqual(result[40].count, 160926)
        XCTAssertEqual(result[41].count, 211627)
        XCTAssertEqual(result[42].count, 168965)
        XCTAssertEqual(result[43].count, 300057)
        XCTAssertEqual(result[44].count, 287212)
        XCTAssertEqual(result[45].count, 265751)
        XCTAssertEqual(result[46].count, 291619)
        XCTAssertEqual(result[47].count, 187225)
        XCTAssertEqual(result[48].count, 114046)
        XCTAssertEqual(result[49].count, 143345)
        XCTAssertEqual(result[50].count, 161826)
        XCTAssertEqual(result[51].count, 110896)
        XCTAssertEqual(result[52].count, 178418)
        XCTAssertEqual(result[53].count, 198276)
        XCTAssertEqual(result[54].count, 343976)
        XCTAssertEqual(result[55].count, 291424)
        XCTAssertEqual(result[56].count, 171786)
        XCTAssertEqual(result[57].count, 327938)
        XCTAssertEqual(result[58].count, 227540)
        XCTAssertEqual(result[59].count, 176276)
        XCTAssertEqual(result[60].count, 145822)
        XCTAssertEqual(result[61].count, 134439)
        XCTAssertEqual(result[62].count, 136061)
        XCTAssertEqual(result[63].count, 247644)
        XCTAssertEqual(result[64].count, 251587)
        XCTAssertEqual(result[65].count, 263401)
        XCTAssertEqual(result[66].count, 229786)
        XCTAssertEqual(result[67].count, 343476)
        XCTAssertEqual(result[68].count, 360521)
        XCTAssertEqual(result[69].count, 200680)
        XCTAssertEqual(result[70].count, 153731)
        XCTAssertEqual(result[71].count, 228339)
        XCTAssertEqual(result[72].count, 129435)
        XCTAssertEqual(result[73].count, 246488)
        XCTAssertEqual(result[74].count, 277009)
        XCTAssertEqual(result[75].count, 146101)
        XCTAssertEqual(result[76].count, 244411)
        XCTAssertEqual(result[77].count, 64698)
        XCTAssertEqual(result[78].count, 232399)
        XCTAssertEqual(result[79].count, 310554)
        XCTAssertEqual(result[80].count, 154126)
        XCTAssertEqual(result[81].count, 421736)
        XCTAssertEqual(result[82].count, 266178)
        XCTAssertEqual(result[83].count, 186247)
        XCTAssertEqual(result[84].count, 215800)
        XCTAssertEqual(result[85].count, 263740)
        XCTAssertEqual(result[86].count, 346947)
        XCTAssertEqual(result[87].count, 216062)
        XCTAssertEqual(result[88].count, 111714)
        XCTAssertEqual(result[89].count, 296876)
        XCTAssertEqual(result[90].count, 226008)
        
        // I got the result by running the program and so hope it wont change
//        for i in 0..<result.count {
//            print("XCTAssertEqual(result[\(i)].count, \(result[i].count))")
//        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
