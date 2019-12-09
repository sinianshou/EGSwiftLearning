//
//  Map.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/29.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit

class Map: NSObject {
    let stringArray = ["123", "234", "345", "456", "abc"]
    func testMap() -> () {
        var result = stringArray.map(intoInt)
        print(result)
        //         [Optional(123), Optional(234), Optional(345), Optional(456), nil]
        result = stringArray.map({string -> Int? in
            return Int(string)
        })
        print(result)
        //         [Optional(123), Optional(234), Optional(345), Optional(456), nil]
        // $0代表数组中的每一个元素
        result = stringArray.map{
            return Int($0)
        }
        print(result)
        //        [Optional(123), Optional(234), Optional(345), Optional(456), nil]
        result = stringArray.map { (string) in
            Int(string)
        }
        print(result)
        //        [Optional(123), Optional(234), Optional(345), Optional(456), nil]
    }
    func intoInt(string: String) -> Int? {
        return Int(string)
    }
    func testCompactMap() -> () {
        var result = stringArray.compactMap(intoInt)
        print(result)
        //         [123, 234, 345, 456]
        result = stringArray.compactMap({string -> Int? in
            return Int(string)
        })
        print(result)
        //         [123, 234, 345, 456]
        // $0代表数组中的每一个元素
        result = stringArray.compactMap{
            return Int($0)
        }
        print(result)
        //         [123, 234, 345, 456]
        result = stringArray.compactMap { (string) in
            Int(string)
        }
        print(result)
        //         [123, 234, 345, 456]
    }
    
        func testCompactMapValues() -> () {
            let dic = ["key1":"123","key2":"abc","key3":nil,nil:"123",]
            var result = dic.compactMap { $0 }
            print(result)
    //        [(key: Optional("key3"), value: nil), (key: Optional("key1"), value: Optional("123")), (key: Optional("key2"), value: Optional("abc")), (key: nil, value: Optional("123"))]
            let result1 = dic.compactMapValues { $0; }
            print(result1)
    //        [Optional("key2"): "abc", Optional("key1"): "123", nil: "123"]
        }
            func testFlatMap() -> () {
                let arr1 = [["1", "2", "3"], ["4", "5", nil]]
                let arr2 = [["1", "2", "3"], ["4", "5", "6"], nil]
                let r1 = arr1.map({$0})
                let r2 = arr2.flatMap({$0})
                let r3 = arr1.map({$0.map({$0})})
                let r4 = arr2.flatMap({$0.flatMap({$0})})
                print(r1)
                print(r2)
                print(r3)
                print(r4)
    }
}
