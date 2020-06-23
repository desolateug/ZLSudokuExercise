//
//  NewExerciseViewController.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/2.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

class NewExerciseViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var typingNumberView: TypingNumberView!
    
    private var showAnswer = true
    
    private var exercise: Exercise?
    
    private var sample = Sample(rank: 3)
    
    private var inputIndexPaths = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTest()
    }
        
    private func setupSubviews() {
        typingNumberView.maxNumber = sample.maxNum
        typingNumberView.delegate = self
    }
    
    private func updateUI() {
        let sample = exercise?.sample ?? self.sample
        var highlightIndexPaths = [IndexPath]()
        for i in 0..<sample.maxNum {
            for j in 0..<sample.maxNum {
                let indexPath = IndexPath(x: i, y: j)
                if sample[indexPath] != 0 {
                    highlightIndexPaths.append(indexPath)
                }
            }
        }
        canvasView.highlightIndexPaths = highlightIndexPaths
        
        if let exercise = exercise {
            canvasView.sample = showAnswer ? exercise.result : exercise.sample
        } else {
            canvasView.sample = sample
        }
    }
    
    private func setupTest() {
        let lock = NSLock()
        var total: TimeInterval = 0
        DispatchQueue.global().async {
            let count = 100
            for i in 0..<count {
                lock.lock()
                let start = Date().timeIntervalSince1970
                ExerciseMaker.newExercise(rank: 3) { _ in
                    let end = Date().timeIntervalSince1970
                    NSLog("%lf", end - start)
                    total += end - start
                    lock.unlock()
                    if i == count - 1 {
                        NSLog("total: %lf", total/Double(count))
                    }
                }
            }
        }
    }
    
    // MARK: - action
    
    @IBAction func exerciseAction(_ sender: Any) {
        HUD.showLoading()
        ExerciseMaker.newExercise(sample: sample) { (exercise) in
            HUD.hideLoading()
            if let exercise = exercise {
                NSLog("%@", exercise.description)
                self.showAnswer = true
                self.exercise =  exercise
                self.updateUI()
            } else {
                let alert = UIAlertController(title: nil, message: "无解", preferredStyle: .alert)
                let ok = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func showAnswerAction(_ sender: Any) {
        showAnswer = !showAnswer
        updateUI()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        showAnswer = true
        exercise = nil
        sample.reset()
        inputIndexPaths.removeAll()
        updateUI()
    }
}

extension NewExerciseViewController: TypingNumberViewDelegate {
    func typingNumberView(_ view: TypingNumberView, select number: Int) {
        if let indexPath = canvasView.selectedIndexPath {
            sample[indexPath] = number
            inputIndexPaths.append(indexPath)
            exercise = nil
            updateUI()
        }
    }
}
