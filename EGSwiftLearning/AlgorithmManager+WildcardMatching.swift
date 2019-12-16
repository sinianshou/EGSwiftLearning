//
//  AlgorithmManager+WildcardMatching.swift
//  EGSwiftLearning
//
//  Created by Easer Liu on 2019/12/16.
//  Copyright © 2019 Easer. All rights reserved.
//
enum MatchType : Int {
    case Single=0
    case RangePlus=1
    case Range=2
    case Split=3
}
extension AlgorithmManager {
    func wildcardMatchingChecker(_ s: String, p: String) -> Bool {
        let sArr = s.map({$0})
        let pArr = p.map({$0})

        print(sArr, pArr)
        //Single,RangePlus,Range   *,?,letter
        let status = [
            [MatchType.Range, MatchType.Single, MatchType.Single],
            [MatchType.Range, MatchType.RangePlus, MatchType.Split],
            [MatchType.Range, MatchType.RangePlus, MatchType.Split]
        ]
        var container = [[0,0,MatchType.Single]]
        while container.count != 0 {
            let el = container.first!
            var sInd : Int = el[0] as! Int
            let pInd : Int = el[1] as! Int
            var cType : MatchType = el[2] as! MatchType
            for pElInd in pInd ..< pArr.count {
                if sInd >= sArr.count {
                    sInd = sArr.count+1
                    break
                }
                let  pEl = pArr[pElInd]
                if cType != MatchType.Split {
                    cType = status[cType.rawValue][self.charType(pEl)]

                    switch cType {
                    case .Single:
                    print("Single")
                        if pEl == Character("?"){
                            sInd+=1
                        }else if pEl.isLetter{
                            if pEl == sArr[sInd] {
                                sInd+=1
                            }else{
                                break
                            }
                        }
                    case .Range:
                        print("range")
                    case .Split:
                    print("Split")
                        for index in sInd ..< sArr.count {

                            print("Split", pEl == sArr[index], pEl , sArr[index])
                            if pEl == sArr[index] {
                                container.append([index,pElInd,MatchType.Single])
                            }
                        }
                    case .RangePlus:
                    print("RangePlus")
                        sInd+=1
                    }
                }else{
                    for index in sInd ..< sArr.count {
                        if pEl == sArr[index] {
                            container.append([index,pElInd,MatchType.Single])
                        }
                    }
                }
            }
            if sInd == s.count {
                return true
            }else if (sInd < s.count && (cType == .Range || cType == .RangePlus)){
                return true
            }
            container.removeFirst()
        }
//        var i = 0
//        for pEl in pArr {
//            if cMatchType != MatchType.Split {
//                cMatchType = status[cMatchType.rawValue][self.charType(pEl)]
//                switch cMatchType {
//                case .Single:
//                print("Single")
//                    if pEl == Character("?"){
//                        i+=1
//                    }else if pEl.isLetter{
//                        if pEl == sArr[i] {
//                            i+=1
//                        }else{
//                            return false
//                        }
//                    }
//                case .Range:
//                    print("range")
//                case .Split:
//                print("Split")
//
//                case .RangePlus:
//                print("RangePlus")
//                    i+=1
//                }
//            }else{
//
//            }
//        }
        
//        if i == s.count {
//            return true
//        }else if (cMatchType == .Range || cMatchType == .RangePlus){
//            return true
//        }
        return false
    }
    func charType(_ ch:Character) -> Int {

        if ch == Character("*"){
            return 0
        }else if ch == Character("?"){
            return 1
        }else if ch.isLetter{
            return 2
        }
        return -1
    }
    
}
