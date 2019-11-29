//
//  Map.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/29.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit

class Map: NSObject {
    func testMap() -> () {
        let stringArray = ["123", "234", "345", "456", "abc"]
        var result = stringArray.map(stringCount)
        print(result)
         //[2, 5, 5, 4, 11]
        result = stringArray.map({string -> Int? in
            return Int(string)
        })
        print(result)
         //[2, 5, 5, 4, 11]
        // $0代表数组中的每一个元素
        result = stringArray.map{
            return Int($0)
        }
        print(result)
        result = stringArray.map { (string) in
        Int(string)
        }
        print(result)
    }
    func stringCount(string: String) -> Int? {
        return Int(string)
    }
}
