//
//  AlgorithmManager+LongestValidParentheses.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/3/17.
//  Copyright © 2020 Easer. All rights reserved.
//
private extension String {
    subscript (index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

extension AlgorithmManager {
    func longestValidParentheses(_ s: String) -> Int {
        let len = s.count
        // 长度小于 2 的时候，成不了一组 () 所以返回 0
        if len < 2 {
            return 0
        }
        // 将 s 转换成数组，方便操作
        let s = Array(s)
        // max 数组 记录当前有效括号最大长度
        var max = Array(repeating: 0, count: len)
        // res 作为结果
        var res = 0
        // 从 1 开始遍历 s
        for i in 1 ..< len {
            // 只有当前字符为 ")" 时，才有可能出现有效括号
            if s[i] == ")" {
                // 用 i 减去 max[i-1] 的中间位置有效括号长度，再减去当前字符长度 1，即为与当前有效括号的 ( 的位置 j
                let j = i - 1 - max[i-1];
                // 只有当 j >= 0，并且 s[j] 为 ( 时，有效括号才匹配
                if j >= 0 && s[j] == "(" {
                    //有效括号匹配，更新 max[i] 的值，当前成对括号长度 2 ，中间位置有效括号长度 max[i-1]，左侧有效括号长度 max[j-1]，加和在一起
                    max[i] = 2 + max[i-1] + (j > 1 ? max[j-1] : 0)
                    //更新较大值到 res
                    res = max[i] > res ? max[i] : res
                }
            }
        }
        return res
    }
}
