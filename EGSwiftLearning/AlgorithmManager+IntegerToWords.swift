//
//  AlgorithmManager+IntegerToWords.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2020/2/5.
//  Copyright © 2020 Easer. All rights reserved.
//
let belowTen = ["Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine"]
let teens = ["Ten", "Eleven", "Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"]
let belowHundreds = ["","Ten","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"]
extension AlgorithmManager {
    func numberToWords(_ num: Int) -> String {
        var result = ""
        var secNum = 0
        if(num < 10){
            //个位数
            result = belowTen[num]
        }else if (num < 20){
            //10 至 19
            result = teens[num % 10]
        }else if (num < 100){
            //20 至 99
            //判断类似于 Twenty One 这种两个单词表示的情况
            secNum = num % 10
            result = belowHundreds[num / 10] + ((secNum == 0) ? "" :" " + belowTen[secNum])
        } else if (num < 1000) {
            // 100 至 999
            // 从百位数拆分 并将百位数单位插入 并将十个位递归
            secNum = num % 100
            return belowTen[num / 100] + " Hundred" + ((secNum == 0) ? "" :" " + self.numberToWords(secNum))
        } else if (num < 1000000) {
            // 1001 至 999999
            // 从千位数拆分 并将千位数单位插入 并将拆开的两部分递归
            secNum = num % 1000
            return self.numberToWords(num / 1000) + " Thousand" + ((secNum == 0) ? "" :" " + self.numberToWords(secNum))
        } else if (num < 1000000000) {
            // 1000001 至 1000000000
            // 从百万位数拆分 并将百万位数单位插入 并将拆开的两部分递归
            secNum = num % 1000000
            return self.numberToWords(num / 1000000) + " Million" + ((secNum == 0) ? "" :" " + self.numberToWords(secNum))
        } else {
            // 大于 1000000001
            // 从十亿位数拆分 并将十亿位数单位插入 并将拆开的两部分递归
            secNum = num % 1000000000
            return self.numberToWords(num / 1000000000) + " Billion" + ((secNum == 0) ? "" :" " + self.numberToWords(secNum))
        }
        return result
    }
}
