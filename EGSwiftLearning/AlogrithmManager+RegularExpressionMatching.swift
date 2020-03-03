//
//  AlogrithmManager+RegularExpressionMatching.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/3/3.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager{
    func isMatch(_ s: String, _ p: String) -> Bool {
        //将 String 转化成 Array ，方便获取字符
        let s = Array(s),p = Array(p)
        //m n 为 s p 的长度
        let m = s.count, n = p.count
        //dp[i][j] 表示 s 前 i 个字符与 p 前 j 个字符是否匹配，默认值为 false
        var dp = Array(repeating: Array(repeating: false, count: n+1), count: m+1)
        // s p 均为空时是匹配的，所以 dp[0][0] = true
        dp[0][0] = true
        //由于 p 为空时，只有当 s 也为空才为 true，其余情况皆为 false
        // 之前已经设置好 dp[0][0] = true ，所以 p 可以从 1 遍历到 n
        // 将 n 为 0 的情况直接跳过，返回结果
        if n > 0 {
            //遍历 s 的长度，从 0 到 m
            for i in 0 ... m {
                // 遍历 p 的长度，
                for j in 1 ... n {
                    //基本分为下面三种情况
                    //需要注意的是这里 i j 表示的是长度，所以取第 i 为字符时应该用 s[i-1]
                    //1.当 p[j - 1] 不为 *，且 s[i - 1] 与 p[j - 1] 匹配（包括字符相同和 p[j-1] 为 . ）时，dp[i][j] = dp[i - 1][j - 1]
                    //2.当 p[j - 1] 为 *，且 * 没有进行匹配时，dp[i][j] = dp[i][j - 2]
                    //3.当 p[j - 1] 为 *，且 * 进行一次匹配时，dp[i][j] = dp[i - 1][j] && (s[i - 1] == p[j - 2] || p[j - 2] == '.')
                    
                    // 当 j 至少为 2 位，且 p[j-1] 为 * 时，这个 * 才合理
                    if (j > 1 && p[j-1] == "*") {
                        // 若 * 合理，则将上面情况 2 和情况 3 进行融合，只有满足其中一种情况，即匹配成功
                        dp[i][j] = dp[i][j - 2] || (i > 0 && (s[i-1]  == p[j-2] || p[j-2] == ".") && dp[i - 1][j])
                    }else{
                        // 若没有合理的 * ，则正常判断是否符合情况 1
                        dp[i][j] = i > 0 && dp[i - 1][j - 1] && (s[i-1] == p[j-1] || p[j-1] == ".")
                    }
                }
            }
        }
        //返回结果
        return dp[m][n];
    }
}
