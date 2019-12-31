//
//  AlgorithmManager+ReversePairs.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/24.
//  Copyright © 2019 Easer. All rights reserved.
//


extension AlgorithmManager {
    func reversePairs(_ nums: [Int]) -> Int {
//        return self.mergesortSolution(nums)
        return self.BITSolution(nums)
    }
    
    func BITSolution(_ nums: [Int]) -> Int{
        //初始化 res 为0
        var res:Int = 0
        //将数组排序赋予 copy
        let copy:[Int] = nums.sorted(by:<)
        //初始化 BIT ，默认值为0，因为 BIT 是从位置 1 开始的，所以长度要比 nums 多 1
        var bit:[Int] = [Int](repeating:0,count:copy.count + 1)
        //遍历 nums 中的数字
        for ele in nums
        {
            // index 方法获取数字在 copy 的位置，若不存在则会返回大于范围的一个值
            // 在 bit 中返回大于等于 2 * ele + 1 的总数量加值给 res
            res += search(&bit, index(copy, 2 * ele + 1))
            // 由于 copy 是顺序数组，所以 ele 在 copy 中的位置 index 可以代替 ele 本身的价值
            insert(&bit, index(copy, ele))
        }
        //返回结果
        return res
    }
    
    //寻找 val 在 arr中的 index
    func index(_ arr:[Int],_ val:Int) -> Int
    {
        //初始化 l m r，分别表示左序号，中间序号，右序号
        var l:Int = 0
        var r:Int = arr.count - 1
        var m:Int = 0
        //不断循环，直至 l > r
        while(l <= r)
        {
            // m 取 l r 的中间值
            m = l + ((r - l) >> 1)
            //若 arr[m] >= val 将 r = m - 1，缩小区间
            if arr[m] >= val
            {
                r = m - 1
            }
            else
            {
                //否则将 l = m + 1，缩小区间
                l = m + 1
            }
        }
        //遍历结束后，l 即为 val 在 arr 中的 index
        //若不存在时，l 则为超出 arr 范围的值
        //由于 BIT 是从 1 开始的，所以返回值为 l + 1
        return l + 1
    }
    
    // 在 bit 中寻找所有大于 i 的值的个数
    // 由于 bit 中反向存储的 ele 在 copy 中的 index，相同值每次叠加 1，所以将 i 及之后的所有值求和即为结果
    func search(_ bit:inout [Int],_ i:Int) -> Int
    {
        // 将 i 变为可变量
        var i = i
        // 初始化 sum = 0
        var sum:Int = 0
        // 从 i 开始遍历 bit，并将 i 之后的元素加和
        while(i < bit.count)
        {
            sum += bit[i]
            i += i & -i
        }
        // 返回加和后的结果 sum
        return sum
    }
    
    // 在 bit 的位置 i 中将数值 +1
    // 由于需要得知的是符合条件的数值的数量，所以没必要将数值存进去，将相应位置 +1 即可，也能方便计数
    func insert(_ bit:inout [Int],_ i:Int)
    {
        // 将 i 变为可变量
        var i = i
        // 循环将 i 及其影响的父节点对应值 +1
        while(i > 0)
        {
            bit[i] += 1
            i -= i & -i
            print(i)
        }
    }
    
    
    func mergesortSolution(_ nums: [Int]) -> Int{
        //转化为可变数组
        var numArr = nums
        //通过 mergesort_and_count 进行排序和计算结果
        return self.mergesort_and_count(&numArr, start: 0, end: nums.count - 1);
    }
    
    //计算 nums 中 start ... end 范围内的元素中符合 i<j && nums[i] > nums[j] * 2 的数对个数
    //同时进行 mergesort 排序
    func mergesort_and_count(_ nums: inout [Int], start: Int, end: Int)->Int{
        //如果 start < end 才进行操作，否则返回符合条件数对个数为 0
        if (start < end) {
            //从中拆分 nums ，递归
            let mid = (start + end) / 2;
            var j = mid + 1;
            // count 记录符合条件数对个数
            var count = self.mergesort_and_count(&nums, start: start, end: mid) + self.mergesort_and_count(&nums, start: j, end: end);
            //遍历寻找 start <= i <= mid < j <= end 中，nums[i] > nums[j] * 2 的数对个数，并加到 count
            //由于 mid 左右两边都进行了升序排序，所以 j 找到第一个不符合 nums[i] > nums[j] * 2 后即可退出 while 循环，因为在后面都是更大的数，一定会不符合
            for i in start ... mid {
                while (j <= end && nums[i] > nums[j] * 2) {
                    j += 1
                }
                count += j - (mid + 1);
            }
            //mergesort排序
            self.merge(&nums, start: start, mid: mid, end: end);
            //返回结果
            return count;
        }else{return 0;}
    }
    func merge(_ nums: inout [Int], start: Int, mid: Int, end: Int)->Void
    {
        //将数组从 mid 拆分成两个子数组，逐一比对，返回较小者
        let n1 = (mid - start + 1);
        let n2 = (end - mid);
        var L = [Int]();
        var R = [Int]();
        for i in 0 ..< n1{
            L.append(nums[start + i])
        }
        for j in 0 ..< n2{
            R.append(nums[mid + 1 + j])
        }
        var i = 0
        var j = 0
        for k in start ... end {
            if (j >= n2 || (i < n1 && L[i] <= R[j])){
                nums[k] = L[i];
                i+=1
            }else{
                nums[k] = R[j];
                j+=1
            }
        }
        
    }
    
}
