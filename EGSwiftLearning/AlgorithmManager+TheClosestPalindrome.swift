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
//        获取字符串长度
        let len = n.count
//        若字符串长度为个位数，为0则返回1，不为0则返回小于其1的值
        if len<2 {
            var num = Int(n)!
            num = num == 0 ? 1:num-1
            return String(num)
        }
//        判断是有中间字符
        let hasMid = (len%2 == 0) ? false : true
//        获得中间字符或中间左侧的位置
        let midNum = hasMid ? (len / 2) : (len / 2 - 1)
//        获得中间字符或中间左侧的index
        let midIndex = n.index(n.startIndex, offsetBy: midNum)
//        获得中间字符右侧的index
        let midIndexR = n.index(midIndex, offsetBy: 1)
//        获得中间字符左侧的index，但若中间字符为首字符则获取中间字符
        let midIndexL = midNum > 0 ? n.index(midIndex, offsetBy: -1) : midIndex
//        获得左侧字符串
        let leftStr = hasMid ? String(n[n.startIndex ... midIndexL]) : String(n[n.startIndex ... midIndex])
//        获得右侧字符串
        var rightStr = String(n[midIndexR ..< n.endIndex])
//        将右侧字符串逆序
        rightStr = String(rightStr.reversed())
//        获得中间字符
        var midStr = String(n[midIndex])
//        创建SET容器
        var set = Set<Int>()
//        创建数组，用于与中间数字加减1和0用
        let arr = [-1, 0, 1]
//        获得中间字符的数字
        let mid = Int(midStr)!
//        遍历数组
        for e in arr{
//            将中间数字加减1和0
            let num = mid + e
//            若结果在0~9范围内，则有效
            if (num>=0) && (num<=9){
//                获得加减1和0后的数字并字符串化
                midStr = String(num)
//                将左侧字符串，中间字符，左侧字符串的逆序拼接起来
                var str = leftStr + midStr + String(leftStr.reversed())
//                若是没有中间字符，则应该讲中间字符替换掉左侧字符串的最后一个字符，并将左侧字符及其逆序拼接起来
                if !hasMid {
                    str = leftStr
//                    str = leftStr + String(leftStr.reversed())
//                    str.replaceSubrange(midIndex ... midIndexR, with: midStr+midStr)
                    str.remove(at: midIndex)
                    str = str + midStr + midStr + String(str.reversed())
                }
//                将与原字符串不相同的结果插入SET容器
                if str != n{
                    set.insert(Int(str)!)
                }
            }
        }
//        算出升位和降位的最近回数，并插入SET容器
        let a = Int(pow(Double(10), Double(len)) + 1)
        let b = Int(pow(Double(10), Double(len-1)) - 1)
        set.insert(a)
        set.insert(b)
//        获取源字符串的数字
        let numOri = Int(n)!
//        声明最小回数和偏差
        var minNum = -1
        var minOffset = -1
//        遍历SET容器，将元素与原数字比较，获取最近回数
        for el in set {
            let offset = abs(numOri - el)
            if(minOffset == -1)||(minOffset > offset){
                minOffset = offset
                minNum = el
            }else if(minOffset == offset){
//                如果有两个回数的偏差相同，取较小值
                minNum = min(minNum, el)
            }
        }
//        返回最近且较小的回数字符串
        return String(minNum)
    }
    
}
