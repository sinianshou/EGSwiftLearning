//
//  AlgorithmManager+TextJustification.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/1/24.
//  Copyright © 2020 Easer. All rights reserved.
//

extension AlgorithmManager {
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        //添加字符串的数组
        var result = [String]()
        //动态字符串长度 strCount，头位置 from 尾位置to
        var strCount = 0, from = 0, to = 0
        //循环条件，to 在 words 范围内
        while to < words.count {
            // 空格数 spaceCount = to - from
            // 字符数 + spaceCount > maxWidth , 或者 to 不在 words 范围中时，跳出循环，
            while to < words.count && strCount + words[to].count + to - from <= maxWidth {
                //循环条件内，添加动态字符串长度
                strCount += words[to].count
                //to 后移一位
                to += 1;
            }
            // to 指向最后一个单词，应该跳出循环处理最后一行字符串
            if to == words.count {
                break
            }
            // from ~ to-1 的单词加上空格数满足条件，进行处理
            let strEl = self.fillSpace(words, maxWidth: maxWidth, from: from, to: to - 1, wordsLen: strCount)
            //将处理后的字符串添加进 result 中
            result.append(strEl)
            // 将 from 指向 to
            from = to
            // 重置 strCount 为 0
            strCount = 0
        }
        //处理最后一行字符串
        let strEl = self.fillLastLine(words, maxWidth: maxWidth, from: from, to: to - 1, wordsLen: strCount)
        result.append(strEl)
        //返回结果
        return result
    }

    func fillSpace(_ words: [String], maxWidth: Int, from: Int, to: Int, wordsLen: Int) -> String{
        var resStr = ""
        let space = "*"
        //单词数量 wordsCount
        let wordsCount = to - from + 1
        //较大空格的数量 larCount
        var larCount = 0
        //空格的长度 spaceLen
        var spaceLen : Int = 1
        if wordsCount<3 {
            //单词数量小于3时，larCount=0，spaceLen=maxWidth - wordsLen
            spaceLen = maxWidth - wordsLen
        }else{
            //单词数量大于等于3时，计算 larCount ，spaceLen
            larCount = (maxWidth - wordsLen) % (wordsCount - 1)
            spaceLen = (maxWidth - wordsLen) / (wordsCount - 1)
        }
        //from ~ to 单词加空格赋值给 resStr
        for idx in from ... to {
            resStr += words[idx]
            var spaceLen1 = spaceLen
            if larCount>0 {
                //若 larCount大于0，索命本次空格数量为 spaceLen + 1
                spaceLen1 += 1
                // larCount - 1
                larCount -= 1
            }
            //若不是最后一个单词，且并非只有一个单词时，添加空额
            //若是最后一个单词，且只有一个单词时，添加空格
            if (idx != to && wordsCount != 1) || (idx == to && wordsCount == 1)  {
                for _ in 0 ..< spaceLen1 {
                    resStr += space
                }
            }
        }
        //返回结果
        return resStr
    }
    func fillLastLine(_ words: [String], maxWidth: Int, from: Int, to: Int, wordsLen: Int) -> String {
        var resStr = ""
        let space = "*"
        //如果 from 小于 to
        if from < to {
            // from ~ to-1 单词和空格 加值到 resStr
            for idx in from ..< to {
                resStr += words[idx] + space
            }
        }
        // resStr 加最后一个单词
        resStr += words[to]
        //剩余空间用空格补齐
        let starNum = maxWidth - resStr.count
        for _ in 0 ..< starNum {
            resStr += space
        }
        //返回结果
        return resStr
    }
}
