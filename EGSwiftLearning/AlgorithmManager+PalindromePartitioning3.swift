//
//  AlgorithmManager+PalindromePartitioning3.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/7.
//  Copyright © 2019 Easer. All rights reserved.
//

extension AlgorithmManager {
    func palindromePartition(_ s: String, _ k: Int) -> Int {
        //        字符串的长度
        let len = s.count
        //        创建动态规划数组dp[i][j],表示前j+1位子串分割成i+1个回文所需要改变字符的最小个数
        var dp = Array(repeating: Array(repeating: Int.max, count: len), count: k)
        //        初始化切割成0+1=1个回文时所需改变字符最小数
        for i in 0 ... len-1 {
            dp[0][i] = self.initOnePartition(str: s.prefix(i+1))
        }
        //        只有k>1时，才需要之后的操作
        if k>1 {
            
            //        循环从切割1+1=2到k个回文
            for i in 1...k-1 {
                //            循环从前i位子串到len位子串
                for j in i ... len-1 {
                    //                当j==i时，即将子串的每个字符切割成回文，不用改变字符
                    if j==i {
                        dp[i][j] = 0
                    } else {
                        //                    当子串的长度开始大于切割的回文数时，循环切割前i至前j-1位子串
                        for t in i-1 ... j-1 {
                            //                        获取t+1至j的子串，并计算回文修改字符最小数tail
                            let tail = self.initOnePartition(str: s.prefix(j+1).suffix(j-t))
                            //                        将前t位子串切割成i-1个回文所需修改最小数，与tail相加，即为本次所需修改字符数
                            var temp = dp[i-1][t] + tail
                            temp = min(dp[i][j], temp)
                            //                        将此次循环的最小数存于dp[i][j]中
                            dp[i][j] = temp
                            if temp == 0 {
                                break
                            }
                        }
                    }
                }
            }
        }
        print(dp)
        //        返回将s切成k个回文所需修改字符最小数
        return dp[k-1][len-1];
    }
//    切割成一个回文需要修改字符的最小数
    func initOnePartition(str:Substring) -> Int {
        let endIndex = str.endIndex
//        循环次数不会字符长度的超过一半
        var num = 0
        let len = str.count/2
//        初始化结果
        var result = 0
//        循环字符串
        for ch in str {
//            当循环到字符长度一半次数时，退出循环
            if (num >= len) {
                break
            }
//            获取前后对应字符并比较
            let indexE = str.index(endIndex, offsetBy: -1*(num+1))
            let chE = str[indexE]
//            若不相等，则需要修改字符，结果+1
            if(ch != chE){
                result += 1
            }
            num += 1
        }
        return result
    }
}
