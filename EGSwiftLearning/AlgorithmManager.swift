//
//  AlgorithmManager.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/17.
//  Copyright © 2019 Easer. All rights reserved.
//

import UIKit

class AlgorithmManager: NSObject {
    class func cryptopangrams(N:NSInteger, L:NSInteger, ARR:[NSInteger]) -> Any{
        var firstNum = -1
        var secondNum = -1
        var index = 0
        
        for i in 0 ..< L{
            if ARR[i] != ARR[i+1] {
                firstNum = ARR[i]
                secondNum = ARR[i+1]
                index = i
                break
            }
        }
        if firstNum < 0 || secondNum < 0 {
            return -1
        }
        let fac = self.findMaxCommonFactor(num1: firstNum, num2: secondNum)
        let preArr = self.unlockNumArr(from: index, to: 0, fac: fac, arr: ARR).reversed()
        let nextArr = self.unlockNumArr(from: index+1, to: L-1, fac: fac, arr: ARR)
        var cryArrM = [NSInteger]()
        cryArrM.append(contentsOf: preArr)
        cryArrM.append(fac)
        cryArrM.append(contentsOf: nextArr)
        let cryStr = self.decriptCryptopangrams(cryArr: cryArrM)
        
        return 1
    }
    class func findMaxCommonFactor(num1:NSInteger, num2:NSInteger) -> NSInteger{
        var lNum = num1 > num2 ? num1 : num2
        var sNum = num1 < num2 ? num1 : num2
        var rNum = lNum % sNum
        while rNum != 0 {
            lNum = sNum
            sNum = rNum
            rNum = lNum % sNum
        }
        return sNum
    }
    class func unlockNumArr(from:NSInteger, to:NSInteger, fac:NSInteger, arr:[NSInteger]) -> [NSInteger]{
        var result = [NSInteger]()
        var facVar = fac
        for i in from ... to {
            let num = arr[i] / facVar
            result.append(num)
            facVar = num
        }
        return result
    }
    class func decriptCryptopangrams(cryArr:[NSInteger]) -> NSString{
        var cryArrM = [NSInteger]()
        for num in cryArr {
            if cryArrM.count > 0 {
                for i in cryArrM.count-1 ... 0 {
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
                if cryArrM.count >= 26 {
                    break
                }
            }else{
                cryArrM.append(num)
            }
        }
        let charArr :[NSString] = ["A","B","C","D","E","F","G","H","I","G","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        var map = [NSString:NSString]()
        for i in 0 ..< cryArrM.count {
            let num = cryArrM[i]
            map[NSString(num)] =  charArr[i]
        }
        var result = ""
        for num in cryArr {
            result += map[NSString(num)]
        }
        return ""
    }
}
