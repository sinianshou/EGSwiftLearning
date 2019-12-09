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
            return 0
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
            }else if (index>0 && repeatsTmp[index-1]>1){
                repeats.append(self.configRepeatChar(num: repeatsTmp[index-1]))
            }
            pre = ch
            index += 1
        }
        if index==len && repeatsTmp[index-1]>1 {
            repeats.append(self.configRepeatChar(num: repeatsTmp[index-1]))
        }
        print(repeats)
        repeats.sort { (i1, i2) -> Bool in
            i1["dNum"]! < i2["dNum"]!
        }
        print(repeats)
        
        if len<6 {
            var insertNum = 6-len
            var index = 0
            for repeatNum in repeats {
                if insertNum > repeatNum["iNum"]! {
                    insertNum = insertNum - repeatNum["iNum"]!
                    repeats.remove(at: index)
                }else{
                    insertNum = 0
                    let iNum = repeatNum["iNum"]! - insertNum
                    repeats.remove(at: index)
                    repeats.append(self.configRepeatChar(num: iNum*3))
                    break
                }
                index += 1
            }
            
        }else if (len>20){
            var dNum = len-20
            var index = 0
            for repeatNum in repeats {
                if dNum > repeatNum["dNum"]! {
                    dNum = dNum - repeatNum["dNum"]!
                    repeats.remove(at: index)
                }else{
                    dNum = 0
                    let dNum = repeatNum["dNum"]! - dNum
                    repeats.remove(at: index)
                    repeats.append(self.configRepeatChar(num: dNum+2))
                    break
                }
                index += 1
            }
            
        }else{
            
        }
        return 0
    }
    func configRepeatChar(num: Int) -> [String:Int]{
        let n = num/3
        return ["dNum":num-2, "iNum":n, "rNum":n, ]
    }
}
