//
//  AlgorithmManager+NthMagicalNumber.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/4/7.
//  Copyright © 2020 Easer. All rights reserved.
//


extension AlgorithmManager {
    func nthMagicalNumber(_ N: Int, _ A: Int, _ B: Int) -> Int {
        // 当 N 为 1 时，返回 A B 的较小值
        if N == 1 {
            return min(A, B)
        }
        // a b tmp 用于辗转相除求最大公约数
        var a = A,b = B,tmp = 0
        while (b > 0)
        {
            tmp = a
            a = b
            b = tmp % b
        }
        // 最大公约数为 a，最小公倍数为 lcm
        let lcm = A * B / a
        // 二分搜索的左右边界
        var l = 2,r = Int(1e14)
        while (l < r)
        {
            // 中值 m
            let m = (l + r) / 2;
            // m / A + m / B - m / lcm 得出的结果为 m 是第几个神奇数字
            if m / A + m / B - m / lcm < N
            {
                l = m + 1
            }
            else
            {
                r = m
            }
        }
        return Int(l % Int(1e9 + 7))
    }
}
