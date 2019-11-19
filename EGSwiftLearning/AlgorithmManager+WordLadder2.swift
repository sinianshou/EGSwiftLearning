//
//  AlgorithmManager+WordLadder2.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/19.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
extension AlgorithmManager{
    class func WordLadder2Solution(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
        var hashSet = Set<String>();
        hashSet = hashSet.union(wordList);
        hashSet.insert(beginWord);
        if(!hashSet.contains(endWord)){
            return [[String]]();
        }
        var index = 0;
        var start = 0;
        var end = 0;
        var list = [String]()
        for s in hashSet {
            list.append(s)
            if s == beginWord {
                start = index;
            }
            if s == endWord {
                end = index;
            }
            index += 1
        }
        let size = list.count;
                 var graph = [[Bool]]();
        for i in 0 ..< size {
            for j in i+1 ... size {
                if self.HasPath(word1: list[i], word2: list[j]) {
                    graph[i][j] = true;
                    graph[j][i] = true;
                }
            }
        }
        var d = [Int]();
        var countInq = [Int]();
        var inq = [Bool]();
        var pre = [Set<String>]();
        for _ in 0 ..< size {
            d.append(Int.max)
            countInq.append(0)
            pre.append(Set<String>())
        }
//        self.SPFA(start: start, list: list);
//        self.DFS(end: end, list: list);
//                spfa(start);
//                dfs(end);
//                return listList;
        
        return [["tring"]];
    }
    class func HasPath(word1:String, word2:String) -> Bool{
        var count = 0
        let word1Arr = Array(word1)
        let word2Arr = Array(word2)
        for i in 0 ..< word1.count {
            if word1Arr[i] == word2Arr[i] {
                count += 1
            }
        }
        return true
    }
    
    class func SPFA(start:Int, list:[String], graph:[[Bool]]) -> Bool{
        let size = list.count;
        var d = [Int]();
        var countInq = [Int]();
        var inq = [Bool]();
        var pre = [Set<Int>]();
        for _ in 0 ..< size {
            d.append(Int.max)
            countInq.append(0)
            pre.append(Set<Int>())
        }
        d[start] = 0;
        var queue = [Int]()
        queue.append(start)
        var headIndex = 0
        var tailIndex = 1
        let modulo = 1000
        countInq[start] += 1;
        inq[start] = true;
        
        while headIndex == tailIndex {
            let u = queue[headIndex];
            headIndex = (1 + headIndex) % modulo
            inq[u] = false;
            for v in 0 ..< size {
                if(graph[u][v]){
                    if(d[u] + 1 < d[v]) {
                        pre[v].removeAll();
                        pre[v].insert(u);
                        d[v] = d[u] + 1;
                        if (!inq[v]) {
                            queue.append(v);
                            tailIndex = (1 + tailIndex) % modulo
                            countInq[v]+=1;
                            inq[v] = true;
                            if (countInq[v] > size - 1) {
                                return false;
                            }
                        }
                    }else if(d[u] + 1 == d[v]){
                        pre[v].insert(v);
                        if (!inq[v]) {
                            queue.append(v);
                            tailIndex = (1 + tailIndex) % modulo
                            countInq[v]+=1;
                            inq[v] = true;
                            if (countInq[v] > size - 1) {
                                return false;
                            }
                        }
                    }
                }
            }
        }
        
        return true
    }
    
    class func DFS(end:Int, list:[String]) -> Bool{
        return true
    }
}
