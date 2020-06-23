//
//  DoExerciseViewController.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/2.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

class DoExerciseViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var typingNumberView: TypingNumberView!
    
    private let caculator = ExerciseCalculator()
    
    private var inputSample: Sample {
        return sample.copy(indexPaths: inputIndexPaths)
    }
    
    private var sample = Sample(rank: 3)
    
    private var inputIndexPaths = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        updateUI()
//        setupTest()
    }
    
    private func setupTest() {
        sample[0, 2] = 8
        sample[0, 4] = 9
        sample[1, 0] = 6
        sample[1, 2] = 4
        sample[1, 8] = 7
        sample[2, 3] = 5
        sample[2, 4] = 4
        sample[2, 6] = 6
        sample[3, 0] = 7
        sample[3, 3] = 2
        sample[3, 4] = 5
        sample[3, 6] = 3
        sample[3, 8] = 6
        sample[4, 0] = 3
        sample[4, 3] = 7
        sample[5, 1] = 9
        sample[5, 3] = 1
        sample[5, 5] = 3
        sample[6, 6] = 9
        sample[7, 0] = 1
        sample[7, 6] = 8
        sample[7, 7] = 3
        sample[8, 0] = 9
        sample[8, 1] = 5
        sample[8, 7] = 1
        
        HUD.showLoading()
        caculator.calculateResult(sample: sample) { (results) in
            HUD.hideLoading()
            if let result = results.first {
                self.sample = result
                self.updateUI()
            } else {
                let alert = UIAlertController(title: nil, message: "无解", preferredStyle: .alert)
                let ok = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupSubviews() {
        typingNumberView.delegate = self
    }
    
    private func updateUI() {
        canvasView.sample = sample
        canvasView.highlightIndexPaths = inputIndexPaths
    }

    // MARK: - action
    
    @IBAction func clearAction(_ sender: Any) {
        if let indexPath = canvasView.selectedIndexPath {
            sample[indexPath] = 0
            inputIndexPaths.removeAll { $0 == indexPath }
            updateUI()
        }
    }
    
    @IBAction func doAction(_ sender: Any) {
        HUD.showLoading()
        caculator.calculateResult(sample: inputSample) { (results) in
            HUD.hideLoading()
            if let result = results.first {
                self.sample = result
                self.updateUI()
            } else {
                let alert = UIAlertController(title: nil, message: "无解", preferredStyle: .alert)
                let ok = UIAlertAction(title: "确定", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func resetAction(_ sender: Any) {
        sample.reset()
        inputIndexPaths.removeAll()
        updateUI()
    }
    
}

extension DoExerciseViewController: TypingNumberViewDelegate {
    func typingNumberView(_ view: TypingNumberView, select number: Int) {
        if let indexPath = canvasView.selectedIndexPath {
            sample[indexPath] = number
            inputIndexPaths.append(indexPath)
            updateUI()
        }
    }
}
