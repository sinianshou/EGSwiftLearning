//
//  AlgorithmManager+ShortestSubarray.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/1/6.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager {
    func shortestSubarray(_ A: [Int], _ K: Int) -> Int {
        //A的长度n
        let n = A.count;
        //初始化结果res，初始值为max
        var res = Int.max;
        //初始化队列dq
        var dq = [Int]();
        //初始化累加队列sums
        var sums = [0];
        for a in A{
            sums.append(sums.last! + a)
        }
        //遍历sums
        for i in 0 ... n{
            //当队列不为空，且 [dq[0], i] 符合条件时，更新 res ，dq 删除头
            while (dq.count > 0 && sums[i] - sums[dq[0]] >= K){
                res = min(res, i - dq[0]);
                dq.remove(at: 0)
            }
            //当队列不为空，且 [dq.last, i] <= 0 时， dq 删除尾
            while (dq.count > 0 && sums[i] <= sums[dq.last!]){
                dq.remove(at: dq.count-1)
            }
            //将 i 加入 dq 尾部
            dq.append(i)
        }
        //返回结果
        return res == Int.max ? -1 : res
    }
}
