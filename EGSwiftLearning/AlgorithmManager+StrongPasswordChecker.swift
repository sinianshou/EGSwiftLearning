//
//  AlgorithmManager+StrongPasswordChecker.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/9.
//  Copyright © 2019 Easer. All rights reserved.
//

extension AlgorithmManager {
    func strongPasswordChecker(_ s: String) -> Int {
        let len = s.count
        if len==0 {
            return 6
        }
        var repeatsTmp = [Int](repeating: 1, count: len)
        var repeats = [[String:Int]]()
        var lower = true
        var upper = true
        var digit = true
        var mustNum = 3
        var pre : Character? = nil
        var index = 0
        for ch in s {
            if(ch.isLowercase && lower){
                lower = false
                mustNum -= 1
            }else if(ch.isUppercase && upper){
                upper = false
                mustNum -= 1
            }else if(ch.isNumber && digit){
                digit = false
                mustNum -= 1
            }
            if pre == ch {
                repeatsTmp[index] = 1 + repeatsTmp[index-1]
                repeatsTmp[index-1] = 1
            }else if (index>0 && repeatsTmp[index-1]>2){
                repeats.append(self.configRepeatChar(num: repeatsTmp[index-1]))
            }
            pre = ch
            index += 1
        }
        if index==len && repeatsTmp[index-1]>2 {
            repeats.append(self.configRepeatChar(num: repeatsTmp[index-1]))
        }
        print(repeats)
        if repeats.count>1 {
            repeats.sort { (i1, i2) -> Bool in
                i1["dNum"]! < i2["dNum"]!
            }
        }
        print(repeats)
        var steps = 0
        if len<6 {
            var insertNum = 6-len
            var index = 0
            for repeatNum in repeats {
                if insertNum > repeatNum["iNum"]! {
                    insertNum = insertNum - repeatNum["iNum"]!
                    mustNum = mustNum - repeatNum["iNum"]!
                    steps += repeatNum["iNum"]!
                    repeats.remove(at: index)
                }else{
                    mustNum = mustNum - insertNum
                    let iNum = repeatNum["iNum"]! - insertNum
                    steps += insertNum
                    insertNum = 0
                    repeats.remove(at: index)
                    repeats.append(self.configRepeatChar(num: iNum*3))
                    break
                }
                mustNum = mustNum<0 ? 0 : mustNum
                index += 1
            }
            if insertNum>0 {
                mustNum = mustNum - insertNum
                mustNum = mustNum<0 ? 0 : mustNum
                steps += insertNum
            }
        }else if (len>20){
            var deleNum = len-20
            var index = 0
            for repeatNum in repeats {
                if deleNum > repeatNum["dNum"]! {
                    deleNum = deleNum - repeatNum["dNum"]!
                    steps += repeatNum["dNum"]!
                    repeats.remove(at: index)
                }else{
                    let dNum = repeatNum["dNum"]! - deleNum
                    steps += deleNum
                    deleNum = 0
                    repeats.remove(at: index)
                    repeats.append(self.configRepeatChar(num: dNum+2))
                    break
                }
                index += 1
            }
            if deleNum>0 {
                steps += deleNum
            }
        }
        var iNum = 0
        for repeatNum in repeats {
            iNum += repeatNum["iNum"]!
        }
        steps += iNum>mustNum ? iNum : mustNum
        return steps
    }
    func configRepeatChar(num: Int) -> [String:Int]{
        let n = num/3
        return ["dNum":num-2, "iNum":n, "rNum":n, ]
    }
}
