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
        // max 数组 记录当前字符适配的最大长度
        var max = Array(repeating: 0, count: len)
        // res 作为结果
        var res = 0
        // 从 1 开始遍历 s
        for i in 1 ..< len {
            // 只有当前字符为 ")" 时，才有可能出现成对的 ()
            if s[i] == ")" {
                // 如果前一个字符时 ( ,则相邻两个字符成一对，长度为 2 ，再加上 max[i-2]的长度即可
                if s[i-1] == "(" {
                    max[i] = 2 + (i > 2 ? max[i-2] : 0)
                }else{
                    //如果前一个字符是 ），则假设与当前字符成对的括号内是存在合理成对括号的
                    // 用 i 减去 max[i-1] 的成对字符长度，再减去当前字符长度 1，即为与当前字符成对的括号的位置 j
                    let j = i - 1 - max[i-1];
                    // 只有当 j >= 0，并且 s[j] 为 ( 时，假设才成立
                    if j >= 0 && s[j] == "(" {
                        //假设成立，更新 max[i] 的值，当前成对括号长度 2 ，括号内括号长度 max[i-1]，当前字符成对的括号 ( ，其左边字符匹配的长度，加和都一起
                        max[i] = 2 + max[i-1] + (j > 1 ? max[j-1] : 0)
                    }
                }
                //更新较大值到 res
                res = max[i] > res ? max[i] : res
            }
        }
        return res
    }
}
