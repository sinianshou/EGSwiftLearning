//
//  DataBuilder.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/17.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit

class DataBuilder: NSObject {
    class func cryptopangramsData() -> [String:Any]{
//        the result should be SUBDERMATOGLYPHICFJKNQVWXZ
        return [
            "N":10000,
            "L":25,
            "ARR":[3292937,175597,18779,50429,375469,1651121,2102,3722,2376497,611683,489059,2328901,3150061,829981,421301,76409,38477,291931,730241,959821,1664197,3057407,4267589,4729181,5335543]
        ];
    }
    class func ValidNumberData() -> [String]{
//        "0" => true
//        " 0.1 " => true
//        "abc" => false
//        "1 a" => false
//        "2e10" => true
//        " -90e3   " => true
//        " 1e" => false
//        "e3" => false
//        " 6e-1" => true
//        " 99e2.5 " => false
//        "53.5e93" => true
//        " --6 " => false
//        "-+3" => false
//        "95a54e53" => false
        return [
            "0", "0.1", "abc", "1 a", "2e10", "-90e3", " 1e", "e3", " 6e-1", " 99e2.5", "53.5e93", " --6", "-+3", "95a54e53", "  6", "6.6e6.6", "6.6.6", "6.6e6.6.6", "6e6e", " ", "  ", "1 ", ".1", "1.", "3. ", " .3", "4e+", "+.8", ".-4", "46.e3"
        ]
    }
}
