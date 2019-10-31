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
        if(count<3){
            return count;
        }
        var maxPoint = 0
        for pointFK in 0 ..< count-1 {
            let pf = points[pointFK]
            var map = [Double:Int]()
            var samePointNum = 0
            var line = 0
            var currentMaxPoint = 0
            for pointTK in pointFK+1 ..< count {
                let pt = points[pointTK]
                let vx = Double(pt[0]-pf[0])
                let vy = Double(pt[1]-pf[1])
                var key = Double(0)
                if(vx != 0 && vy == 0){
                    line += 1
                    continue
                }else if(vx == 0 && vy == 0){
                    samePointNum += 1
                    continue
                }else{
                    key = vx/vy
                }
                if(map.keys.contains(key)){
                    map[key]! += 1;
                }else{
                    map[key] = 1;
                }
                if(map[key]! > currentMaxPoint){
                    currentMaxPoint = map[key]!
                }
            }
            currentMaxPoint = currentMaxPoint > line ? currentMaxPoint : line
            currentMaxPoint += samePointNum + 1
            maxPoint = currentMaxPoint > maxPoint ? currentMaxPoint : maxPoint
        }
        return maxPoint
    }
}
