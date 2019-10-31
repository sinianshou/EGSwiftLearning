//
//  AlgorithmManager+MacPointsOnLine.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/10/31.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
extension AlgorithmManager{
    class func MaxPointOnLineSolution(points:[[Int]]) -> Int{
        let count = points.count
//        当坐标点数量小于3时，最多点数即为坐标点数量
        if(count<3){
            return count;
        }
//        声明最多点数
        var maxPoint = 0
//        外层循环，用以拿到比较的坐标点
        for pointFK in 0 ..< count-1 {
//            获取比较的坐标点
            let pf = points[pointFK]
//            以斜率为key，被比较的坐标点数为value，声明一个dictionary
            var map = [Double:Int]()
//            声明变量用以记录相同的被比较坐标点数
            var samePointNum = 0
//            声明变量用以记录y差值为0，即在同一水平线的d被比较坐标点数
            var line = 0
//            声明变量记录此次外层循环中，除两种特殊情况的最多的被比较坐标点数
            var currentMaxPoint = 0
//            内层循环，用以拿到被比较的坐标点
            for pointTK in pointFK+1 ..< count {
//                获取被比较的坐标点
                let pt = points[pointTK]
//                计算两点的x、y的差值
                let vx = Double(pt[0]-pf[0])
                let vy = Double(pt[1]-pf[1])
                var key = Double(0)
                if(vx != 0 && vy == 0){ //当y的差值为0时，水平点数+1，并跳过此次循环
                    line += 1
                    continue
                }else if(vx == 0 && vy == 0){   //当两点重复时，记录相同点数，并跳过此次循环
                    samePointNum += 1
                    continue
                }else{  //计算斜率
                    key = vx/vy
                }
                if(map.keys.contains(key)){ //若斜率的key已存在，将value 点数 +1
                    map[key]! += 1;
                }else{  //若斜率的key不存在，则创建key
                    map[key] = 1;
                }
//                更新当前外层循环中，除两种特殊情况的最多的被比较坐标点数
                if(map[key]! > currentMaxPoint){
                    currentMaxPoint = map[key]!
                }
            }
//            与水平点数比较并更新当前外层循环的最多点数
            currentMaxPoint = currentMaxPoint > line ? currentMaxPoint : line
//            将相同点数以及比较坐标点计算到当前外层循环的最多点数
            currentMaxPoint += samePointNum + 1
//            更新最终的最多点数
            maxPoint = currentMaxPoint > maxPoint ? currentMaxPoint : maxPoint
        }
        return maxPoint
    }
}
