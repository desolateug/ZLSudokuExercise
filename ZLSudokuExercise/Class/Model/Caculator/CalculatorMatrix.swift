//
//  CalculatorModel.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/10.
//  Copyright © 2020 zlj. All rights reserved.
//

import Foundation

class CalculatorModel {
    let indexPath: IndexPath
    var usableNumbers: [Int]
    
    init(indexPath: IndexPath, usableNumbers: [Int] = []) {
        self.indexPath = indexPath
        self.usableNumbers = usableNumbers
    }
    
    convenience init(model: CalculatorModel) {
        self.init(indexPath: model.indexPath, usableNumbers: model.usableNumbers)
    }
}

class CalculatorMatrix {
    var list = [CalculatorModel]()
    var map = [IndexPath : CalculatorModel]()
    var result: Sample!
    
    convenience init(sample: Sample) {
        self.init()
        update(sample: sample)
    }
    
    convenience init(matrix: CalculatorMatrix) {
        self.init()
        self.result = matrix.result
        for (indexPath, model) in matrix.map {
            map[indexPath] = CalculatorModel(model: model)
        }
        for model in matrix.list {
            list.append(map[model.indexPath]!)
        }
    }
    
    func update(sample: Sample) {
        list.removeAll()
        map.removeAll()
        for i in 0..<sample.maxNum {
            for j in 0..<sample.maxNum {
                let indexPath = IndexPath(x: i, y: j)
                let nums = sample.getUsableNumbers(indexPath: indexPath)
                let model = CalculatorModel(indexPath: indexPath, usableNumbers: nums)
                map[indexPath] = model
                list.append(model)
            }
        }
        // 移除sample中已经确定的
        list.removeAll {
            $0.usableNumbers.count == 1 && sample[$0.indexPath] != 0
        }
        list.sort { $0.usableNumbers.count < $1.usableNumbers.count }
        result = sample
    }
    
    func set(value: Int, at indexPath: IndexPath) {
        guard value != 0 && value <= result.maxNum else { return }
        
        result[indexPath] = value
        map[indexPath]?.usableNumbers = [value]
        list.removeAll { $0.indexPath == indexPath }
        
        // row
        for i in 0..<result.maxNum {
            if i != indexPath.y {
                let indexPath = IndexPath(x: indexPath.x, y: i)
                map[indexPath]?.usableNumbers.removeAll { $0 == value }
            }
        }
        
        // column
        for i in 0..<result.maxNum {
            if i != indexPath.x {
                let indexPath = IndexPath(x: i, y: indexPath.y)
                map[indexPath]?.usableNumbers.removeAll { $0 == value }
            }
        }
        
        // block
        let blockX = indexPath.x/result.rank*result.rank
        let blockY = indexPath.y/result.rank*result.rank
        for i in 0..<result.rank {
            for j in 0..<result.rank {
                if blockX+i != indexPath.x, blockY+j != indexPath.y {
                    let indexPath = IndexPath(x: blockX+i, y: blockY+j)
                    map[indexPath]?.usableNumbers.removeAll { $0 == value }
                }
            }
        }
        
        list.sort { $0.usableNumbers.count < $1.usableNumbers.count }
    }
    
    func next() -> CalculatorModel? {
        return list.first
    }
    
    var isValid: Bool {
        return result.isValid
    }
    
}
