//
//  AlgorithmManager+CreateMaximumNumber.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/3/10.
//  Copyright © 2020 Easer. All rights reserved.
//
import Darwin
extension AlgorithmManager {
    func maxNumber(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [Int] {
        //初始化结果的容器 res
        var res = [Int]()
        //确定循环范围，以 nums1 为基准，k-nums2.count 为 nums1 需要取的最少个数，为了筛除负数，与 0 取较大值
        //nums1 取的最多个数即为 k 和 nums1.count 的较小值
        for i in max(0, k-nums2.count) ... min(k, nums1.count) {
            // 将 nums1 nums2 筛选 i k-i 个元素获得新数组 newNums1 newNums2
            let newNums1 = self.filterNums(nums: nums1, k: i)
            let newNums2 = self.filterNums(nums: nums2, k: k-i)
            // 将 newNums1 newNums2 进行合并，获取临时最大数组 tmp
            let tmp = self.mergeArray(nums1: newNums1, nums2: newNums2)
            // 将 tmp 与 res 进行比较，若 tmp 较大，则替换掉 res
            if self.isLarger(nums1: tmp, nums2: res, i: 0, j: 0){
                res = tmp
            }
        }
        return res
    }
    
    //将 nums 筛选 k 个元素，获取最大数组
    func filterNums( nums: [Int],  k: Int) -> [Int]{
        // k 的边界值处理
        if k<=0 {
            return []
        }else if k >= nums.count{
            return nums
        }
        //初始化结果的容器 res
        var res = [Int]()
        //遍历 nums
        for i in 0 ..< nums.count{
            //获取当前数值 num
            let num = nums[i]
            //若 res 里的尾元素小于 num，并且 res.count + nums.count - i > k
            // res.count + nums.count - i > k 表示 res 的元素数量加上 nums 剩余的元素数量大于 k ，这样才可以继续删除尾元素
            while !res.isEmpty && num > res.last! && res.count + nums.count - i > k {
                res.removeLast()
            }
            //将 num 加入到 res
            res.append(num)
        }
        //移除多余的元素
        res.removeLast(res.count-k)
        // 返回结果
        return res
    }
    
    //将两个数组合并成最大数组
    func mergeArray(nums1: [Int], nums2: [Int]) -> [Int] {
        //初始化结果的容器 res
        var res = [Int]()
        //初始化 nums1 nums2 的序号 i j 为 0
        var i = 0 , j = 0
        //共遍历 nums1.count + nums2.count 次
        for _ in 0 ..< nums1.count + nums2.count {
            //比较 nums1[i,nums1.count] 和 nums2[j,nums2.count]
            //将较大数组的当前元素添加到 res，移动序号 i 或者 j
            if self.isLarger(nums1: nums1, nums2: nums2, i: i, j: j) {
                res.append(nums1[i])
                i += 1
            }else{
                res.append(nums2[j])
                j += 1
            }
        }
        //返回结果
        return res
    }
    
    //判断 nums1 是否大于 nums2
    func isLarger(nums1: [Int], nums2: [Int], i : Int, j : Int) -> Bool {
        var i = i , j = j
        //循环有效的 i j ，且 nums1[i] == nums2[j] 时，i j +1
        while i < nums1.count && j < nums2.count && nums1[i] == nums2[j] {
            i += 1
            j += 1
        }
        //循环结束后的情况：
        //1. nums1 nums2 均没有遍历完，此时比较 nums1[i] > nums2[j]
        //2. nums1 nums2 其中任意一个遍历完，另一个没有遍历完，没有遍历完的数组较大
        //3. nums1 nums2 均遍历完，结果相等
        
        // j == nums2.count 判断 nums2 是否遍历完，
        //若 nums2 遍历完，nums1 也遍历完，则相等返回 true ，覆盖了情况 3
        //若 nums2 遍历完，nums1 没有遍历完，则 nums1 大返回 true，覆盖了情况 2
        //i < nums1.count && nums1[i] > nums2[j] 则覆盖了情况 1
        return j == nums2.count || (i < nums1.count && nums1[i] > nums2[j])
    }
}
