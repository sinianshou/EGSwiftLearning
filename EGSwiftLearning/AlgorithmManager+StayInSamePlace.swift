//
//  AlgorithmManager+StayInSamePlace.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/26.
//  Copyright © 2019 Easer. All rights reserved.
//

extension AlgorithmManager {
    func numWays(_ steps: Int, _ arrLen: Int) -> Int {
        //若步数或者长度为1时，则只有一种路径
        if arrLen <= 1 || steps <= 1{
            return 1
        }
        //设置模
        let mod = 1000000007
        //初始化一步到达的路径数量数组，可达最远位置1，长度为1+1=2，但由于计算二步到达路径数量数组时，会用到一步到达位置2的路径数量，所以需要额外加一个元素，即长度为2+1=3
        var arr = [1, 1, 0]
        //循环从二步到steps步
        for i in 2 ... steps {
            //可到达的最远位置为步数与数组长度的较小值
            let max = min(arrLen-1, i)
            //初始化临时i步到达的路径数量数组，长度为(max+1)+1=max+2
            var temp = [Int](repeating: 0, count: max+2)
            //循环i步可到达位置 0 ~ max 的路径数量数组
            for j in 0 ... max{
                //先获取 i-1 步到达位置 j 的路径数量
                var ans = arr[j]
                switch j {
                //若位置 j 为 0 则加位置 1 的路径数量
                case 0:
                    ans = (ans + arr[1]) % mod
                //若位置 j 为 max 则加位置 max-1 的路径数量
                case max:
                    ans = (ans + arr[max-1]) % mod
                //若位置 j 不为 0 或者 max 则加位置 j-1 和 j+1 的路径数量
                default:
                    ans = (arr[j-1] + ans + arr[j+1]) % mod
                }
                //将 i 步到达位置 j 的路径数量赋值到临时数组的对应位置
                temp[j]=ans
            }
            //将临时i步到达的路径数量数组赋值与 arr 以便求取 i+1 步到达路径数组时用
            arr = temp
        }
        //遍历结束后，arr 即为 steps 步可到达路径数量数组，arr[0] 即为 steps 步到达位置 0 的路径数量
        return arr[0]
    }
}
