//
//  AlgorithmManager+ReversePairs.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/24.
//  Copyright © 2019 Easer. All rights reserved.
//


extension AlgorithmManager {
    func reversePairs(_ nums: [Int]) -> Int {
        //转化为可变数组
        var numArr = nums
        //通过 mergesort_and_count 进行排序和计算结果
        return self.mergesort_and_count(&numArr, start: 0, end: nums.count - 1);
        
        var res:Int = 0
        let copy:[Int] = nums.sorted(by:<)
        var bit:[Int] = [Int](repeating:0,count:copy.count + 1)
        for ele in nums
        {
            res += search(&bit, index(copy, 2 * ele + 1))
            print(bit, res)
            insert(&bit, index(copy, ele))
            print(bit)
        }
        print(bit)
        return res
    }
    
    func index(_ arr:[Int],_ val:Int) -> Int
    {
        var l:Int = 0
        var r:Int = arr.count - 1
        var m:Int = 0
        while(l <= r)
        {
            m = l + ((r - l) >> 1)
            if arr[m] >= val
            {
                r = m - 1
            }
            else
            {
                l = m + 1
            }
        }
        print(arr,val,l+1)
        return l + 1
    }
    
    func search(_ bit:inout [Int],_ i:Int) -> Int
    {
        var i = i
        
        var sum:Int = 0
        while(i < bit.count)
        {
            sum += bit[i]
            i += i & -i
        }
        return sum
    }
    
    func insert(_ bit:inout [Int],_ i:Int)
    {
        var i = i
        while(i > 0)
        {
            bit[i] += 1
            i -= i & -i
        }
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
