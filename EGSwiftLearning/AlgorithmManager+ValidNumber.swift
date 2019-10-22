//
//  ValidNumber.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/22.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
extension AlgorithmManager {
    
    class func ValidNumberSolution(_ s: String) -> Bool {
        var index = 0
        var hasSym = false
        var hasDoc = false
        var hasNum = false
        var pool = [Character]()
        let eValue = Character("e")
        pool.append(eValue)
        let pValue = Character("+")
        pool.append(pValue)
        let sValue = Character("-")
        pool.append(sValue)
        let pointValue = Character(".")
        pool.append(pointValue)
        let blank = Character(" ")
        for i in 0 ... 9{
            pool.append(Character(String(i)))
        }
        for ch in s {
            if(ch == blank)&&(hasNum){
                return false
            }else if(!pool.contains(ch)){
                return false
            }
            
            let chValue = ch.asciiValue
            if(index == 0){
                
                return false
            }else{
                return true
            }
            hasNum = true
            index += 1
        }
        return true
    }
}
