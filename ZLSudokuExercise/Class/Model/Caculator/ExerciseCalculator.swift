//
//  SudokuComputer.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/3.
//  Copyright © 2020 zlj. All rights reserved.
//

import Foundation

class ExerciseCalculator {
    
    private var maxResultCount: Int = 1
    
    private var results = [Sample]()
    
    func calculateResult(sample: Sample, maxResultCount: Int = 1, sync: Bool = false, completion: @escaping ([Sample]) -> Void) {
        guard sample.isValid else {
            completion([])
            return
        }
        
        self.maxResultCount = maxResultCount
        self.results.removeAll()

        let matrix = CalculatorMatrix(sample: sample)
        
        if sync {
            calculateResult(matrix: matrix)
            completion(self.results)
        } else {
            DispatchQueue.global().async {
                self.calculateResult(matrix: matrix)
                DispatchQueue.main.async {
                    completion(self.results)
                }
                
            }
        }
    }
    
    private func calculateResult(matrix: CalculatorMatrix) {
        while let model = matrix.next() {
            switch model.usableNumbers.count {
            case 0:
                return
            case 1:
                let value = model.usableNumbers.first!
                matrix.set(value: value, at: model.indexPath)
            default:
                while model.usableNumbers.count > 0 {
                    let index = Int(arc4random_uniform(UInt32(model.usableNumbers.count)))
                    let newMatrix = CalculatorMatrix(matrix: matrix)
                    newMatrix.set(value: model.usableNumbers[index], at: model.indexPath)
                    calculateResult(matrix: newMatrix)
                    model.usableNumbers.remove(at: index)
                    if results.count >= maxResultCount {
                        return
                    }
                }
                return
            }
        }
        
        results.append(matrix.result)
    }
    
}
