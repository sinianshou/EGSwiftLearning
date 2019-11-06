//
//  AlgorithmManager+LongestDuplicateSubstring.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/6.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation

extension AlgorithmManager{
    class func LongestDuplicateSubstringSolution(_ S:String) -> String{
//        字符串长度
        let len = S.count
//        字符串长度小于2时无重复字串
        if len < 2 {
            return ""
        }
//        26进制
        let factor = 26;
//        设一个较大的模
        let powV : Double = pow(2, 20)
        let module = Int(powV)
        var nums = [Int]()
//        将字符串中的字符转化成ASCII码存入数组
        for sub in S {
            let ch = sub.asciiValue
            nums.append(Int(ch!))
        }
//        初始化重复字串的起始位置
        var start = -1
//        用二分差法，找到最大重复字串的起始位置以及长度
        var low = 1
        var high = len
        while low != high {
//            将长度折半
            let L = (high - low) / 2 + low
//            初始化临时起始位置
            var location = -1
//            初始化hashmap，key是hash值，value是Int数组的数组，用于存放子字符的位置和长度，这里之所以用了数组，而不是直接存放信息，是因为有可能发生两个不同字符串算出的hash值相同的情况，所以即使hash值相同，也要遍历数组确认是否真的是相同字符串
            var hashMap = [Int:[[Int]]]()
//            hash值变量
            var tmp = 0;
//            用于记录进位了几次
            var aL = 1;
//            将第一个折半长度为L的子串的hash值和位置长度算出来并存入hashmap中
            for j in 0 ..< L {
                tmp = (tmp * factor + nums[j]) % module
                aL = (aL * factor) % module
            }
            hashMap[tmp]=[[0,L]]
//            从第二个开始计算hash值
            for j in 1 ... len - L {
//                减去前一位
                tmp = (tmp * factor - nums[j-1] * aL % module + module) % module
//                加上后一位
                tmp = (tmp + nums[j+L-1]) % module
//                如果hashmap的key中已经存在hash值，则遍历数组，逐一对比子串
                if hashMap.keys.contains(tmp) {
//                    用于是否真的重复的标识
                    var isContain = false
//                    获取当前子串
                    let sIndex = S.index(S.startIndex, offsetBy: j)
                    let eIndex = S.index(S.startIndex, offsetBy: j + L)
                    let str = String(S[sIndex ..< eIndex])
//                    获取当前hash值对应的数组
                    let locArr = hashMap[tmp]
//                    遍历数组
                    for locs in locArr!{
//                        获取数组元素对应的子串
                        let sIndex = S.index(S.startIndex, offsetBy: locs[0])
                        let eIndex = S.index(S.startIndex, offsetBy: locs[0] + locs[1])
                        let strInMap = String(S[sIndex ..< eIndex])
//                        对比子串，若相同，将位置赋予临时起始位置，并跳出遍历循环
                        if str == strInMap {
                            location = j
//                            真的重复，将isContain标识置为true
                            isContain = true
                            break
                        }
                    }
//                    如果并未真的重复，则将现位置长度存入数组
                    if(!isContain){
                        var locArr = hashMap[tmp]
                        locArr?.append([j,L])
                    }else{
//                        若真的重复，则跳出检验当前长度L子串是否重复的循环，这样位置获取的就是第一个重复字串的位置
                        break
                    }
                }else{
//                    如果hashmap的key中不含有hash值，则新创建key-value
                    hashMap[tmp] = [[j,L]]
                }
            }
//            如果临时起始位置发生改变，说明此次循环找到了重复的长度为L的子串，将铲毒下线+1，并将起始位置赋值
            if ( location != -1) {
                low = L + 1
                start = location
            }else{
//                临时起始位置未发生改变，说明此次循环没有重复的长度为L的子串，则将长度上限设为L
                high = L
            }
        }
//        若起始位置未发生改变，说明没有找到重复的子串
        if start == -1 {
            return ""
        }
//        否则，依据位置和长度，返回重复的子串
        let startIndex = S.index(S.startIndex, offsetBy: start)
        let endIndex = S.index(S.startIndex, offsetBy: start+low-1)
        return String(S[startIndex ..< endIndex])
    }
//    class func search(L: Int, factor:Int, module:Int, nums:[Int]) -> Int {
//        let len = nums.count
//        var hashSet = Set<Int>()
//        var tmp = 0;
//        var aL = 1;
//        for j in 0 ..< L {
//            tmp = (tmp * factor + nums[j]) % module
//            aL = (aL * factor) % module
//        }
//        hashSet.insert(tmp)
//        for j in 1 ... len - L {
//            tmp = (tmp * factor - nums[j-1] * aL % module + module) % module
//            tmp = (tmp + nums[j+L-1]) % module
//            if hashSet.contains(tmp) {
//                return j
//            }
//            hashSet.insert(tmp)
//        }
//        return -1
//    }
    
}
