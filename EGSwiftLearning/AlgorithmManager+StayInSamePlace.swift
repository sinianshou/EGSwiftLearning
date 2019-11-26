//
//  AlgorithmManager+StayInSamePlace.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/26.
//  Copyright © 2019 Easer. All rights reserved.
//

extension AlgorithmManager {
    func numWays(_ steps: Int, _ arrLen: Int) -> Int {
        if arrLen <= 1 {
            return arrLen
        }
        let mod = 1000000007
        var arr = [Int](repeating: 0, count: arrLen)
        arr[0] = 1
        arr[1] = 1
        for _ in 1 ..< steps {
            var temp = [Int](repeating: 0, count: arrLen)
            for i in 0 ... min(arrLen-1, steps-1) {
                var ans = arr[i]
                if i > 0 {
                    ans = (ans + arr[i-1]) % mod
                }
                if i < arrLen-1 {
                    ans = (ans + arr[i+1]) % mod
                }
                temp[i] = ans
            }
            arr = temp
        }
        return arr[0]
    }
}
