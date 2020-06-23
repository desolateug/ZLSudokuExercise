//
//  SudukuModel.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/2.
//  Copyright © 2020 zlj. All rights reserved.
//

import Foundation

struct Sample {
    let rank: Int
    
    var maxNum: Int {
        return rank*rank
    }
    
    var dataSource: [[Int]]
    
    init(rank: Int) {
        self.rank = rank
        let maxNum = rank*rank
        let rowArray = Array(repeating: 0, count: maxNum)
        dataSource = Array(repeating: rowArray, count: maxNum)
    }
    
    subscript (indexPath: IndexPath) -> Int {
        get {
            return dataSource[indexPath.x][indexPath.y]
        }
        set(newValue) {
            dataSource[indexPath.x][indexPath.y] = newValue
        }
    }
    
    subscript (x: Int, y: Int) -> Int {
        get {
            return dataSource[x][y]
        }
        set(newValue) {
            dataSource[x][y] = newValue
        }
    }
    
    var isValid: Bool {
        for x in 0..<maxNum {
            for y in 0..<maxNum {
                let num = dataSource[x][y]
                if num == 0 {
                    continue
                }
                if !numValid(num, indexPath: IndexPath(x: x, y: y)) {
                    return false
                }
            }
        }
        return true
    }
    
    func numValid(_ num: Int, indexPath: IndexPath) -> Bool {
        for i in 0..<maxNum {
            if i != indexPath.y, dataSource[indexPath.x][i] == num {
                return false
            }
        }
        
        // column
        for i in 0..<maxNum {
            if i != indexPath.x, dataSource[i][indexPath.y] == num {
                return false
            }
        }
        
        // block
        let blockX = indexPath.x/rank*rank
        let blockY = indexPath.y/rank*rank
        for i in 0..<rank {
            for j in 0..<rank {
                if blockX+i != indexPath.x, blockY+j != indexPath.y, dataSource[blockX+i][blockY+j] == num {
                    return false
                }
            }
        }

        return true
    }
    
    mutating func reset() {
        let rowArray = Array(repeating: 0, count: maxNum)
        dataSource = Array(repeating: rowArray, count: maxNum)
    }
    
    func getUsableNumbers(indexPath: IndexPath) -> [Int] {
        var usableNums = [Int]()
        let value = dataSource[indexPath.x][indexPath.y]
        if value != 0 {
            usableNums.append(value)
            return usableNums
        }
        
        for num in 1...maxNum {
            if numValid(num, indexPath: indexPath) {
                usableNums.append(num)
            }
        }
        
        return usableNums
    }
    
    func copy(indexPaths: [IndexPath]) -> Sample {
        var sample = Sample(rank: rank)
        for indexPath in indexPaths {
            sample[indexPath] = self[indexPath]
        }
        return sample
    }
}

extension Sample: CustomStringConvertible {
    
    var description: String {
        var description = "\n"
        for i in 0..<maxNum {
            for j in 0..<maxNum {
                description += String(format: maxNum < 10 ? "%d " : "%2d ", dataSource[i][j])
                if ((j + 1) % rank == 0) {
                    description += " "
                }
            }
            if ((i + 1) % rank == 0) {
                description += "\n"
            }
            description += "\n"
        }
        return description
    }
    
}
