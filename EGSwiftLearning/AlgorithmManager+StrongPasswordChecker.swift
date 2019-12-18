//
//  AlgorithmManager+StrongPasswordChecker.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/9.
//  Copyright © 2019 Easer. All rights reserved.
//

extension AlgorithmManager {
    func strongPasswordChecker(_ s: String) -> Int {
        //字符串长度len
        let len = s.count
        //若是长度为零，返回6
        if len==0 {
            return 6
        }
        //临时计算重复字符数的容器，长度为字符长度，值为1
        var repeatsTmp = [Int](repeating: 1, count: len)
        //记录重复字符数的容器，repeats[i][j]，i 重复字符数余 3 ，范围是 0~2 ，对应数组的元素记录了num(重复字符数),iNum(解决重复问题需插入字符数),rNum(解决重复问题需替换字符数)。
        var repeats = [[[String:Int]](),[[String:Int]](),[[String:Int]]()]
        //大小写字母数字是否存在的表示
        var lower = true
        var upper = true
        var digit = true
        //必须字符类型默认为3
        var mustNum = 3
        // 解决重复问题一共需要插入的数量
        var totalINum = 0
        //记录前一个字符的表示
        var pre : Character? = nil
        //充当s中char的index
        var index = 0
        for ch in s {
            //判断是否为大小写字母和数字，若是，则 mustNum - 1
            if(ch.isLowercase && lower){
                lower = false
                mustNum -= 1
            }else if(ch.isUppercase && upper){
                upper = false
                mustNum -= 1
            }else if(ch.isNumber && digit){
                digit = false
                mustNum -= 1
            }
            //如果当前字符与前一个字符相等，则为重复字符，将repeatsTmp当前对应的值加的前一个位置的值，并重置前一个位置的值为1，只记录该重复字符最终最大值
            if pre == ch {
                repeatsTmp[index] = 1 + repeatsTmp[index-1]
                repeatsTmp[index-1] = 1
            }else if (index>0 && repeatsTmp[index-1]>2){
                //若当前字符与前一个字符不相等，且非首字符，前一个重复值大于2，说明前一个重复字符是需要处理的重复字符，加入到repeats对应位置中
                //n 为重复字符数量
                let n = repeatsTmp[index-1]
                //m 为 n%3 作为 repeats 中对应位置
                let m = n % 3
                //用 configRepeatChar 创建对应元素
                let el = self.configRepeatChar(num: n)
                // 记录总共需要插入的数量
                totalINum += el["iNum"]!
                //将元素加入到repeats对应位置
                repeats[m].append(el)
            }
            //赋值pre和index
            pre = ch
            index += 1
        }
        //循环结束，判断最后一段字符是不是重复字符
        if index==len && repeatsTmp[index-1]>2 {
            let n = repeatsTmp[index-1]
            let m = n % 3
            let el = self.configRepeatChar(num: n)
            totalINum += el["iNum"]!
            repeats[m].append(el)
        }
        //设置解决问题需要的步数，初始化为0
        var steps = 0
        if len<6 {
            //当长度小于6时，解决长度问题需要插入字符操作为1~5步，解决必须字符种类的操作为1~2步，解决重复字符串问题操作为1~2步
            //取三者最大值即可
            let insertNum = 6-len
            steps = max(max(insertNum, mustNum), totalINum)
            return steps
        }else if (len>20){
            //当长度大于20时，deleNum 为需要删除的长度
            var deleNum = len-20
            //以重复长度余3的结果为 0、1、2 的顺序去执行删除 1、2、3个字符的操作
            //因为如此会以最少的删除操作在解决长度问题的同时，尽可能解决重复字符串的问题
            for index in 0 ..< repeats.count {
                //充当index
                var elIn = 0
                for el in repeats[index] {
                    //本次循环可以删除的长度
                    var deleSteps = index + 1
                    //与还需删除的总长度比较，取较小值，防止删除过度
                    deleSteps = deleNum>deleSteps ? deleSteps : deleNum
                    //还需删除的总长度，减去本次删除的长度
                    deleNum -= deleSteps
                    //重复字符长度减去删除长度得到新长度 n
                    let num = el["num"]! - deleSteps
                    let m = num % 3
                    //用 configRepeatChar 创造 n 的新元素，并加入到 repeats 对应位置中
                    let elNew = self.configRepeatChar(num: num)
                    repeats[m].append(elNew)
                    //删除原来的元素
                    let ind = repeats[index].firstIndex(of: el)!
                    repeats[index].remove(at: ind)
                    //如果需删除的总长度为 0 ，则说明长度复合要求，跳出循环
                    if deleNum==0 {
                        break
                    }
                    elIn += 1
                }
                //如果需删除的总长度为 0 ，则说明长度复合要求，跳出循环
                if deleNum==0 {
                    break
                }
            }
            //如果需删除的总长度大于 0 ，则说明重复问题解决后，还需要继续删除字符以解决长度问题，则返回结果为总共需要删除的长度加上mustNum
            if deleNum>0 {
                return len-20+mustNum
            }else{
                //否则，则说明在重复问题解决或解决前，长度问题解决，操作步数则加上需删除的总长度
                steps += len-20
            }
        }
        
        //此时，字符串的长度符合要求，遍历 repeats 取出解决重复字符串总共需要替换的操作步数 rNum
        var rNum = 0
        for els in repeats {
            for el in els {
                rNum += el["rNum"]!
            }
        }
        //rNum 和 mustNum 取较大值，加到总操作步数里
        steps += rNum>mustNum ? rNum : mustNum
        //返回总操作步数
        return steps
    }
    func configRepeatChar(num: Int) -> [String:Int]{
        let m = (num-1)/2
        let n = num/3
        return ["num":num, "iNum":m, "rNum":n]
    }
}
