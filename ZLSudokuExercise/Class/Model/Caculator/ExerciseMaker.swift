//
//  ExerciseMaker.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/4.
//  Copyright © 2020 zlj. All rights reserved.
//

import Foundation

class ExerciseMaker {
    static func newExercise(sample: Sample, completion: @escaping (Exercise?) -> Void) {
        DispatchQueue.global().async {
            var result: Sample?
            guard var finalSample = calculateResult(sample: sample).first else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            var indexPaths = [IndexPath]()
            for i in 0..<sample.maxNum {
                for j in 0..<sample.maxNum {
                    let indexPath = IndexPath(x: i, y: j)
                    if sample[indexPath] == 0 {
                        indexPaths.append(indexPath)
                    }
                }
            }
            
            while indexPaths.count > 0 {
                var tmpResult = finalSample
                let index = Int(arc4random_uniform(UInt32(indexPaths.count)))
                let indexPath = indexPaths[index]
                tmpResult[indexPath] = 0
                let calResults = calculateResult(sample: tmpResult, maxResultCount: 2)
                if calResults.count == 1 {
                    finalSample = tmpResult
                    result = calResults.first!
                }
                indexPaths.remove(at: index)
            }
            
            var exercise: Exercise?
            if let result = result {
                exercise = Exercise(sample: finalSample, result: result)
            }
            
            DispatchQueue.main.async {
                completion(exercise)
            }
        }
    }
    
    static func newExercise(rank: Int, completion: @escaping (Exercise?) -> Void) {
        let sample = Sample(rank: rank)
        newExercise(sample: sample, completion: completion)
    }
    
    private static func calculateResult(sample: Sample, maxResultCount: Int = 1) -> [Sample] {
        let caculator = ExerciseCalculator()
        var result: [Sample]!
        caculator.calculateResult(sample: sample, maxResultCount: maxResultCount, sync: true) { result = $0 }
        return result
    }
}
