//
//  AlgorithmManager+SuperEggDrop.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/2/25.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager {
    func superEggDrop(_ K: Int, _ N: Int) -> Int {
        //dp[moves][K] 表示 K 个鸡蛋走 moves 步可以确认的楼层数 初始值为0
        var dp:[[Int]] = [[Int]](repeating:[Int](repeating:0,count:K + 1),count:N + 1)
        var moves = 0
        //当 dp[moves][K] 的值等于 N 的时候，即找到了符合要求的 moves
        while(dp[moves][K] < N)
        {
            //moves +1 并遍历 1~K 来计算 dp[moves][k] 的值
            moves += 1
            for k in 1...K
            {
                //计算 dp[moves][k] 的值
                //假设第一步在 X 层，丢鸡蛋会有两个结果：
                //  1. 鸡蛋碎了，则还剩下 k-1 个鸡蛋和 moves-1 步，剩余可确认的层数即 dp[moves - 1][k - 1]
                //  2. 鸡蛋没碎，则还剩下 k 个鸡蛋和 moves-1 步，剩余可确认的层数即 dp[moves - 1][k]
                //所以 dp[moves][k] = dp[moves - 1][k - 1] + dp[moves - 1][k] + 1，加值 1 为第一步确认的 X 层
                dp[moves][k] = dp[moves - 1][k - 1] + dp[moves - 1][k] + 1
            }
        }
        //找到 moves 后返回结果
        return moves
    }
}
