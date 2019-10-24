//
//  AlgorithmManager+OnceInTripleArray.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/24.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
extension AlgorithmManager{
    class func OnceInTripleArray(numArr:[Int]) -> Int{
        var FA = 0
        var SA = 0
        var newFA = 0
        var newSA = 0
        for E in numArr{
            newFA = ~SA & (FA^E)
            newSA = (SA^E) & ~(FA^E)
            FA = newFA
            SA = newSA
        }
        return FA
    }
}

