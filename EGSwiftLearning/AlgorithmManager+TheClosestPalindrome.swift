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
        let midNum = len / 2
        print("midnum is ", midNum)
        let midIndex1 = n.index(n.startIndex, offsetBy: midNum)
        let midIndex2 = n.index(midIndex1, offsetBy: 1)
        var hasMid = (len%2 == 0) ? false : true
        var leftStr = String(n[n.startIndex ..< midIndex1])
        var rightStr = hasMid ? String(n[midIndex2 ..< n.endIndex]) : String(n[midIndex1 ..< n.endIndex])
        rightStr = String(rightStr.reversed())
        var midStr = hasMid ? String(n[midIndex1]) : ""
        print(leftStr, midStr, rightStr)
        var c = -1
        var d = -1
        if (leftStr != rightStr) {
            var result = leftStr + midStr + String(leftStr.reversed())
            return result
        }else if(hasMid){
            var mid = Int(midStr)!
            var mid1 =  mid + 1
            var str = ""
            if mid1 < 10 {
                midStr = String(mid1)
                str = leftStr + midStr + rightStr
                c = Int(str)!
            }
            
            mid1 =  mid - 1
            if mid1 > 0 {
                midStr = String(mid1)
                str = leftStr + midStr + rightStr
                d = Int(str)!
            }
        }else{
            
        }
        
        let a = pow(10, len) + 1
        let b = pow(10, len-1) - 1
        return ""
    }
    
}
