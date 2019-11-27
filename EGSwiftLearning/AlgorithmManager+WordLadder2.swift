//
//  AlgorithmManager+WordLadder2.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/11/19.
//  Copyright © 2019 Easer. All rights reserved.
//

import Foundation
//最终结果的容器
var listList = [[String]]();
//最终结果的临时容器
 var tempPath = [Int]()
//用于存储节点到头节点的步数
 var d = [Int]();
//用于存储节点的前置节点数量
 var countInq = [Int]();
//用于判断节点是否在队列中
 var inq = [Bool]();
//用于存储节点的前置节点序号
 var pre = [Set<Int>]();
extension AlgorithmManager{
    class func WordLadder2Solution(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
//        将列表和头单词放入Set中
        var hashSet = Set<String>();
        hashSet = hashSet.union(wordList);
        hashSet.insert(beginWord);
//        如果其中不包含尾单词，则不存在单词接龙，直接返回空
        if(!hashSet.contains(endWord)){
            return [[String]]();
        }
        
        //清空容器
        listList = [[String]]();
        tempPath = [Int]()
        
//        将单词加入到list中，并记录头单词和为单词的序号
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
//        获得单词的数量，并初始化图，
        let size = list.count;
        var graph = [[Bool]](repeating: [Bool](repeating: false, count: size), count: size);
        d = [Int](repeating: Int.max, count: size)
        countInq = [Int](repeating: 0, count: size)
        pre = [Set<Int>](repeating: Set<Int>(), count: size)
        inq = [Bool](repeating: false, count: size)
//        将图中可一步到达的两个单词位置设置为true
        for i in 0 ..< size {
            for j in i+1 ..< size {
                if self.HasPath(word1: list[i], word2: list[j]) {
                    graph[i][j] = true;
                    graph[j][i] = true;}
            }
        }
//        广度优先，配置图中每个节点的前置节点
        self.BFS(start: start, list: list, graph: graph)
//        深度优先，寻找从尾节点到头节点的路径
        self.DFS(start: start, nowVisit: end, list: list)
        
        
//        返回结果
        print(listList)
                return listList;
    }
//    判断两个单词之间是否可一步到达
    class func HasPath(word1:String, word2:String) -> Bool{
        var count = 0
        let word1Arr = Array(word1)
        let word2Arr = Array(word2)
//        遍历两个单词的字符并对比
        for i in 0 ..< word1.count {
//            若字符不相同，则count+1
            if word1Arr[i] != word2Arr[i] {
                count += 1
            }
        }
//        若count为1，则说明只有一个字符相同，则可以一步到达
        if count == 1 {
            return true
        }
//        否则不能一步到达
        return false
    }
//    广度优先，配置节点的前置节点pre
    class func BFS(start:Int, list:[String], graph:[[Bool]]) -> Bool{
//        单词数量
        let size = list.count;
//        头节点到头节点的j步数为0
        d[start] = 0;
//        初始化队列并将头节点序号放入
        var queue = [Int]()
        queue.append(start)
        var headIndex = 0
        var tailIndex = 1
        let modulo = 10000000000
        countInq[start] += 1;
        inq[start] = true;
//        广度优先算法
        while headIndex != tailIndex {
//            出队节点序号
            let u = queue[headIndex];
            headIndex = (1 + headIndex) % modulo
            inq[u] = false;
//            遍历列队序号设置前置节点
            for v in 0 ..< size {
//                若u节点可一步到达v节点，则配置前置节点
                if(graph[u][v]){
//                    若u节点到头节点的步数+1小于v节点到头节点的步数，则清空v节点的前置节点，并将u节点加入
                    if(d[u] + 1 < d[v]) {
                        pre[v].removeAll();
                        pre[v].insert(u);
                        d[v] = d[u] + 1;
//                        若jv节点没有入队则入队
                        if (!inq[v]) {
                            queue.append(v);
                            tailIndex = (1 + tailIndex) % modulo
                            countInq[v]+=1;
                            inq[v] = true;
                            if (countInq[v] > size - 1) {
                                return false;
                            }
                        }
//                    若u节点到头节点的步数+1等于v节点到头节点的步数，则将u节点加入

                    }else if(d[u] + 1 == d[v]){
                        pre[v].insert(u);
//                        若jv节点没有入队则入队
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

//    深度优先，寻找单词接龙
    class func DFS(start:Int, nowVisit:Int, list:[String]) -> (){
//        将当前节点加入临时容器
        tempPath.append(nowVisit)
//        若当前节点为头节点，说明已经找到单词接龙
                if(nowVisit == start){
//                    遍历临时容器，将结果放入到listList
                    var path = [String]()
                    for i in stride(from:tempPath.count-1, through:0, by:-1) {
                        path.append(list[tempPath[i]])
                    }
                    listList.append(path);
//                    删除最后一个节点
                    tempPath.remove(at: tempPath.count - 1);
                    return;
                }
//        遍历当前节点的前置节点，并递归
        for integer in pre[nowVisit] {
            self.DFS(start: start, nowVisit: integer, list: list)
        }
//        删除最后一个节点
                tempPath.remove(at: tempPath.count - 1);
    }
}
