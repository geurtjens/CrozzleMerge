//
//  Test_LoadWords.swift
//  
//
//  Created by Michael Geurtjens on 8/1/2023.
//

import XCTest
import CrozzleMerge

final class Test_LoadWords: XCTestCase {

    func test_Execute() throws {
        let result = LoadWords.Execute(filename: "8612_Words.txt")
        
        XCTAssertEqual(result.count, 91)
       
        XCTAssertEqual(result[0], "ZION")
        XCTAssertEqual(result[1], "AZURE")
        XCTAssertEqual(result[2], "TOYS")
        XCTAssertEqual(result[3], "JOY")
        XCTAssertEqual(result[4], "HAZELNUT")
        XCTAssertEqual(result[5], "NUTS")
        XCTAssertEqual(result[6], "NAZARETH")
        XCTAssertEqual(result[7], "HYMN")
        XCTAssertEqual(result[8], "TURKEY")
        XCTAssertEqual(result[9], "SNOW")
        XCTAssertEqual(result[10], "MERRY")
        XCTAssertEqual(result[11], "TOAST")
        XCTAssertEqual(result[12], "STAR")
        XCTAssertEqual(result[13], "HOLLY")
        XCTAssertEqual(result[14], "JELLY")
        XCTAssertEqual(result[15], "FAMILY")
        XCTAssertEqual(result[16], "WHITE")
        XCTAssertEqual(result[17], "SING")
        XCTAssertEqual(result[18], "SAUCE")
        XCTAssertEqual(result[19], "PORK")
        XCTAssertEqual(result[20], "TREE")
        XCTAssertEqual(result[21], "EVE")
        XCTAssertEqual(result[22], "INN")
        XCTAssertEqual(result[23], "BELLS")
        XCTAssertEqual(result[24], "CAKE")
        XCTAssertEqual(result[25], "GLAZE")
        XCTAssertEqual(result[26], "PARTYHATS")
        XCTAssertEqual(result[27], "TWENTYFIFTH")
        XCTAssertEqual(result[28], "WALNUT")
        XCTAssertEqual(result[29], "PEANUTS")
        XCTAssertEqual(result[30], "PRESENTS")
        XCTAssertEqual(result[31], "FRUIT")
        XCTAssertEqual(result[32], "NUTMEG")
        XCTAssertEqual(result[33], "CUSTARD")
        XCTAssertEqual(result[34], "CHRISTMAS")
        XCTAssertEqual(result[35], "MISTLETOE")
        XCTAssertEqual(result[36], "GIFTS")
        XCTAssertEqual(result[37], "SANTACLAUS")
        XCTAssertEqual(result[38], "FESTIVE")
        XCTAssertEqual(result[39], "RAISINS")
        XCTAssertEqual(result[40], "LIGHTS")
        XCTAssertEqual(result[41], "WREATH")
        XCTAssertEqual(result[42], "HOLIDAY")
        XCTAssertEqual(result[43], "WISEMEN")
        XCTAssertEqual(result[44], "CRANBERRY")
        XCTAssertEqual(result[45], "OPENHOUSE")
        XCTAssertEqual(result[46], "SILENTNIGHT")
        XCTAssertEqual(result[47], "STOCKING")
        XCTAssertEqual(result[48], "PUNCH")
        XCTAssertEqual(result[49], "WINE")
        XCTAssertEqual(result[50], "SHOPPING")
        XCTAssertEqual(result[51], "PLUMPUDDING")
        XCTAssertEqual(result[52], "WRAPPING")
        XCTAssertEqual(result[53], "NEIGHBOURS")
        XCTAssertEqual(result[54], "GREETINGS")
        XCTAssertEqual(result[55], "DECORATIONS")
        XCTAssertEqual(result[56], "ALMONDS")
        XCTAssertEqual(result[57], "LANTERN")
        XCTAssertEqual(result[58], "KRISSKRINGLE")
        XCTAssertEqual(result[59], "SPICE")
        XCTAssertEqual(result[60], "GOODWILL")
        XCTAssertEqual(result[61], "BONBON")
        XCTAssertEqual(result[62], "CHURCH")
        XCTAssertEqual(result[63], "FRIENDS")
        XCTAssertEqual(result[64], "PARCELS")
        XCTAssertEqual(result[65], "CINNAMON")
        XCTAssertEqual(result[66], "NICHOLAS")
        XCTAssertEqual(result[67], "MINCEPIES")
        XCTAssertEqual(result[68], "CHERRIES")
        XCTAssertEqual(result[69], "SLEIGH")
        XCTAssertEqual(result[70], "ALMOND")
        XCTAssertEqual(result[71], "MANGER")
        XCTAssertEqual(result[72], "RIBBON")
        XCTAssertEqual(result[73], "CHOCOLATE")
        XCTAssertEqual(result[74], "MIXEDPEEL")
        XCTAssertEqual(result[75], "DRINK")
        XCTAssertEqual(result[76], "CANDLES")
        XCTAssertEqual(result[77], "FOOD")
        XCTAssertEqual(result[78], "GINGER")
        XCTAssertEqual(result[79], "BETHLEHEM")
        XCTAssertEqual(result[80], "CAROL")
        XCTAssertEqual(result[81], "REINDEER")
        XCTAssertEqual(result[82], "GOODCHEER")
        XCTAssertEqual(result[83], "CREAM")
        XCTAssertEqual(result[84], "CORDIAL")
        XCTAssertEqual(result[85], "CHILDREN")
        XCTAssertEqual(result[86], "ICECREAM")
        XCTAssertEqual(result[87], "CHICKEN")
        XCTAssertEqual(result[88], "CARD")
        XCTAssertEqual(result[89], "DECEMBER")
        XCTAssertEqual(result[90], "PEACE")
        // I got the result by running the program and so hope it wont change
//        for i in 0..<result.count {
//            print("XCTAssertEqual(result[\(i)], \"\(result[i])\")")
//        }
    }
}