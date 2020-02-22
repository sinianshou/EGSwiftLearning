//
//  AlgorithmManager+SplitArraySameAverage.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/2/13.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager {
    func splitArraySameAverage(_ nums: [Int]) -> Bool {
        // n 为 nums 的长度
        let n = nums.count
        // 长度为 0 或者 1 时，说明长度无法形成符合的分拆，返回 false
        if n < 2 { return false }
        // sum 为 nums 加和
        let sum = nums.reduce(0, +)
        // 循环 1 到 n/2
        for i in 1 ... n/2 {
            // 若存在 i 符合 (sum * i) % n == 0 则可能成功拆分成 i 和 n-i 个元素的符合的子数组
            if ((sum * i) % n == 0) {
                // 判断 nums 中从 nums[0] 开始，是否存在 i 个元素取得加和为 sum * i / n
                if isExist(nums, i, 0, sum * i / n) {
                    // 若可以 ，则符合条件，返回 true
                    return true
                }
            }
        }
        // 走到这里说明没有符合条件的 i ，返回 false
        return false
    }
    
    // 判断 nums 中从 nums[len] 开始，是否存在 idx 个元素取得加和为 sum
    func isExist(_ nums: [Int], _ len: Int, _ idx: Int, _ sum: Int) -> Bool {
        // 由于用的是加和值递减元素值得方法，所以当 sum 和 len 均为 0 时，说明是符合条件的，返回 true
        if sum == 0, len == 0 { return true }
        // idx len sum 非法时，返回 false
        if idx >= nums.count || len < 0 || sum < 0 { return false }
        // 从 idx 遍历到 end ，进行递归，用 sum-nums[i]，同事 len 长度 -1 ，i 起始索引 +1
        for i in idx..<nums.count {
            // 若 nums[i] == nums[i - 1] ，因为重复操作，可以跳过本次循环
            if i > idx && nums[i] == nums[i - 1] { continue }
            if isExist(nums, len - 1, i + 1, sum - nums[i]) { return true }
        }
        // 走到这里，没有遇到符合条件的 sum len，则返回 false
        return false
    }
}
