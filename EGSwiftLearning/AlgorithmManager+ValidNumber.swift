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
        var hasDoc = false
        var hasE = false
        var pool = [Character]()
        var numPool = [Character]()
        var symPool = [Character]()
        let eValue = Character("e")
        pool.append(eValue)
        let pValue = Character("+")
        symPool.append(pValue)
        let sValue = Character("-")
        symPool.append(sValue)
        let pointValue = Character(".")
        pool.append(pointValue)
        let blank = Character(" ")
        for i in 0 ... 9{
            numPool.append(Character(String(i)))
        }
        pool.append(contentsOf: symPool)
        pool.append(contentsOf: numPool)
        
        
        var pCh : Character? = nil
        for ch in s {
            let hasPCH = (pCh != nil)
            if(ch == blank)&&hasPCH{
                if pool.contains(pCh!) {
                    return false
                }
            }
            if !pool.contains(ch) && ch != blank {
                return false
            }
            if (symPool.contains(ch))&&hasPCH{
                if (pCh != blank) && (pCh != eValue) {
                    return false
                }
            }
            if (ch == pointValue) {
                if(!hasPCH || hasDoc){
                    return false
                }else if(!numPool.contains(pCh!)){
                    return false
                }
                hasDoc = true
            }
            
            if (ch == eValue) {
                if(!hasPCH || hasE){
                    return false
                }else if(!numPool.contains(pCh!)){
                    return false
                }
                hasE = true
                hasDoc = false
            }
            pCh = ch
        }
        return true
    }
}
