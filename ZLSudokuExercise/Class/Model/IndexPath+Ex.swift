//
//  ZLIndexPath.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/10.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

extension IndexPath {
    var x: Int {
        return self[0]
    }
    
    var y: Int {
        return self[1]
    }
    
    init(x: Int, y: Int) {
        self.init(indexes:[x, y])
    }
}
