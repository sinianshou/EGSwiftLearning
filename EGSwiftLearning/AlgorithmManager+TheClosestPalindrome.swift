//
//  AlgorithmManager+TheClosestPalindrome.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/11.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
extension AlgorithmManager{
    class func NearestPalindromicSolution(_ n: String) -> String{
        let len = n.count
        if len<2 {
            var num = Int(n)!
            num -= 1
            num = num < 0 ? num+2:num
            return String(num)
        }
        let hasMid = (len%2 == 0) ? false : true
        let midNum = hasMid ? (len / 2) : (len / 2 - 1)
        let midIndex = n.index(n.startIndex, offsetBy: midNum)
        let midIndexR = n.index(midIndex, offsetBy: 1)
        let midIndexL = midNum > 0 ? n.index(midIndex, offsetBy: -1) : midIndex
        let leftStr = hasMid ? String(n[n.startIndex ... midIndexL]) : String(n[n.startIndex ... midIndex])
        var rightStr = String(n[midIndexR ..< n.endIndex])
        rightStr = String(rightStr.reversed())
        var midStr = String(n[midIndex])
        print(leftStr, midStr, rightStr)
        var set = Set<Int>()
        let arr = [-1, 0, 1]
        let mid = Int(midStr)!
        for e in arr{
            let num = mid + e
            if (num>=0) && (num<=9){
                midStr = String(num)
                var str = leftStr + midStr + String(leftStr.reversed())
                if !hasMid {
                    str = leftStr + String(leftStr.reversed())
                    str.replaceSubrange(midIndex ... midIndexR, with: midStr+midStr)
                }
                if str != n{
                    set.insert(Int(str)!)
                }
            }
        }
        let a = Int(pow(Double(10), Double(len)) + 1)
        let b = Int(pow(Double(10), Double(len-1)) - 1)
        set.insert(a)
        set.insert(b)
        let numOri = Int(n)!
        var minNum = -1
        var minOffset = -1
        for el in set {
            let offset = abs(numOri - el)
            if(minOffset == -1)||(minOffset > offset){
                minOffset = offset
                minNum = el
            }else if(minOffset == offset){
                minNum = min(minNum, el)
            }
        }
        return String(minNum)
    }
    
}
