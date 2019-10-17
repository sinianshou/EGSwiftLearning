//
//  AlgorithmManager.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/17.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit
//提供解密方法
class AlgorithmManager: NSObject {
    
    /// 解密方法
    /// - Parameter N: 质数最大值
    /// - Parameter L: 密文长度
    /// - Parameter ARR: 密文数组
    class func cryptopangrams(N:NSInteger, L:NSInteger, ARR:[NSInteger]) -> Any{
        var firstNum = -1
        var secondNum = -1
        var index = 0
        //遍历密文，找出两个不相等的密文，即代表着连续的三个不相同字符
        for i in 0 ..< L{
            if ARR[i] != ARR[i+1] {
                firstNum = ARR[i]
                secondNum = ARR[i+1]
                index = i
                break
            }
        }
        //如果没有说明密文有误 返回
        if firstNum < 0 || secondNum < 0 {
            return -1
        }
        //找到公约数
        let fac = self.findMaxCommonFactor(num1: firstNum, num2: secondNum)
        //向前求出质数
        let preArr = self.unlockNumArr(from: 0, to: index, fac: fac, arr: ARR, isReversed: true).reversed()
        //向后求出质数
        let nextArr = self.unlockNumArr(from: index+1, to: L-1, fac: fac, arr: ARR, isReversed: false)
        //整合质数数组
        var cryArrM = [NSInteger]()
        cryArrM.append(contentsOf: preArr)
        cryArrM.append(fac)
        cryArrM.append(contentsOf: nextArr)
        //将质数数组映射成字符串
        let cryStr = self.decriptCryptopangrams(cryArr: cryArrM)
        //返回字符串
        return cryStr
    }
    
    /// 求两个数值的最大公约数
    /// - Parameter num1: 第一个数
    /// - Parameter num2: 第二个数
    class func findMaxCommonFactor(num1:NSInteger, num2:NSInteger) -> NSInteger{
        var lNum = num1 > num2 ? num1 : num2
        var sNum = num1 < num2 ? num1 : num2
        var rNum = lNum % sNum
        //依据的是：被除数A与除数B得出余数C，余数C与除数B的公约数，和被除数A与除数B的公约数相同，所以反复利用这个理论，直到余数C为零时，除数B即为公约数
        while rNum != 0 {
            lNum = sNum
            sNum = rNum
            rNum = lNum % sNum
        }
        return sNum
    }
    
    /// 依据现有质数求出前后的质数
    /// - Parameter from: 开始的序号
    /// - Parameter to: 结束的序号
    /// - Parameter fac: 现有质数
    /// - Parameter arr: 密文数组
    /// - Parameter isReversed: 是否逆序
    class func unlockNumArr(from:NSInteger, to:NSInteger, fac:NSInteger, arr:[NSInteger], isReversed:Bool) -> [NSInteger]{
        //初始化质数数组
        var result = [NSInteger]()
        var facVar = fac
        if isReversed {
            //向前求质数时需要逆序
            for i in (from ... to).reversed() {
                let num = arr[i] / facVar
                result.append(num)
                facVar = num
            }
        }else{
            for i in from ... to {
                let num = arr[i] / facVar
                result.append(num)
                facVar = num
            }
        }
        return result
    }
    
    /// 将质数数组映射为字符串
    /// - Parameter cryArr: 质数数组
    class func decriptCryptopangrams(cryArr:[NSInteger]) -> String{
        var cryArrM = [NSInteger]()
        //先排序质数数组
        for num in cryArr {
            if cryArrM.count > 0 {
                for i in (0 ... cryArrM.count-1).reversed()  {
                    if cryArrM[i] < num {
                        cryArrM.insert(num, at: i+1)
                        break
                    }else if cryArrM[i] == num {
                        break
                    }
                    if i == 0 {
                        cryArrM.insert(num, at: 0)
                    }
                }
                //如果已经有26个了，说明已经全部映射完了，跳出循环
                if cryArrM.count >= 26 {
                    break
                }
            }else{
                cryArrM.append(num)
            }
        }
        let charArr :[String] = ["A","B","C","D","E","F","G","H","I","G","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        var map = [String:String]()
        //将质数与字母进行映射
        for i in 0 ..< cryArrM.count {
            let num = cryArrM[i]
            map[String(num)] =  charArr[i]
        }
        var result = ""
        //依据映射将质数数组替换成字母
        for num in cryArr {
            result += map[String(num)]!
        }
        return result
    }
}
