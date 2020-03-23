//
//  AlgorithmManager+MaxProfit.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/3/23.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager {
    func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
        // 过滤无法买卖的情况
        guard prices.count > 1, k > 0 else { return 0 }
        // 价格走势的天数 priceLen
        let priceLen = prices.count
        // 当交易次数 k 大于 priceLen 的一半时，则每次有涨幅的时候（if (prices[i] > prices[i-1]) ）都进行交易
        if k >= (priceLen / 2) {
            var res = 0
            for i in 1..<priceLen {
                if (prices[i] > prices[i-1]) {
                    res += prices[i] - prices[i-1]
                }
            }
            // 返回结果
            return res
        }
        // 若 k 小于 priceLen 的一半，则需要筛选获利最高的 k 次交易
        // mp[j][i] 为 j 天进行 i 次交易时获得的最大收益
        var mp = [[Int]](repeating: [Int](repeating: 0, count: k + 1), count: prices.count)
        // 遍历 i 次交易
        for i in 1...k {
            // localMax 实际为 mp[i - 1][0] - prices[0]，
            // 由于 mp[i - 1][0] 表示 0 天，所以数值始终未 0 ，可以简写成 localMax = -prices[0]
            // localMax 表示 j 天进行 i-1 次操作后，再以 prices[j] 买入时的最大收益标识
            var localMax = -prices[0]
            //遍历 j 天
            for j in 1..<priceLen {
                // mp[j][i] 表示 j 天进行 i 次交易时获得的最大收益，分两种计算情况
                // 1. 第 j 天没有进行交易，则值与 mp[j-1][i] 相同
                // 2. 在前 j-1 天进行了 i-1 次交易，且在前 j-1 天中某一天进行了买入操作,第 j 天以 prices[j] 的价格卖出(prices[j]+localMax)
                // 两种情况取较大值赋予 mp[j][i]
                mp[j][i] = max(mp[j-1][i], prices[j]+localMax)
                // 不断更新 localMax
                // j-1 天进行 i-1 次交易，并在第 j 天买入的收益（mp[j-1][i-1]-prices[j]），与当前的 localMax 比较取较大值
                localMax = max(localMax, mp[j-1][i-1]-prices[j])
            }
        }
        // 返回 最后一天为止，进行 k 次交易的最大收益值
        return mp[prices.count-1][k]
    }
}
