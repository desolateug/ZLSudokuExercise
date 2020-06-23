//
//  SudokuExercise.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/3.
//  Copyright © 2020 zlj. All rights reserved.
//

import Foundation

struct Exercise {
    var sample: Sample
    var result: Sample
}

extension Exercise: CustomStringConvertible {
    var description: String {
        return "\n" + "Exercise:" + "\(sample)" + "Answer:" + "\(result)"
    }
}
