//
//  AlgorithmManager+SelfCrossing.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/3/30.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager {
    func isSelfCrossing(_ x: [Int]) -> Bool {
        // 变数大于 3 的时候才需要判断，小于等于 3 的时候一定不会相交
        if x.count > 3 {
            for i in 3 ..< x.count {
                // 第 4 条边大等于第 2 条边，第 1 条边大等于第 3 条边，此时第 4+4n 条边和第 1+4n 条边相交（n>=0）
                if (x[i] >= x[i - 2] && x[i - 3] >= x[i - 1]) {
                    return true;
                }
                // 第 2 条边等于第 4 条边，第 5 条边大等于第 3、1 条边的差值，此时第 5+4n 条边和第 1+4n 条边相交（n>=0）
                if (i >= 4 && x[i-1] == x[i-3] && x[i] >= x[i-2] - x[i-4]) {
                    return true;
                }
                // 第 4 条边大等于第 2 条边，第 3 条边大等于第 5 条边，第 5 条边大等于第 3、1 条边的差值，第 6 条边大等于第 4、2 条边的差值，此时第 6+4n 条边和第 1+4n 条边相交（n>=0）
                if (i >= 5 && x[i-2] >= x[i-4] && x[i-3] >= x[i-1] && x[i-1] >= x[i-3] - x[i-5] && x[i] >= x[i-2] - x[i-4]) {
                    return true;
                }
            }
        }
        return false
    }
}
