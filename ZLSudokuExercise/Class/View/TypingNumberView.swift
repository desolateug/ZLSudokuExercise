//
//  TypingNumberView.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/3.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

protocol TypingNumberViewDelegate: AnyObject {
    func typingNumberView(_ view: TypingNumberView, select number: Int)
}

class TypingNumberView: GridView {
    
    override func prepareUI() {
        super.prepareUI()
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        updateUI()
    }
    
    private func updateUI() {
        columnCount = min(maxNumber, 9)
        rowCount = Int(ceil(Double(maxNumber) / Double(columnCount)))
    }
    
    var maxNumber = 9 {
        didSet {
            invalidateIntrinsicContentSize()
            updateUI()
            collectionView.reloadData()
        }
    }
    
    weak var delegate: TypingNumberViewDelegate?
    
    // MARK: - lazy
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CanvasViewCell.self, forCellWithReuseIdentifier: "CanvasViewCell")
        
        return collectionView
    }()
}

extension TypingNumberView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/CGFloat(columnCount)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.typingNumberView(self, select: indexPath.item + 1)
    }
}

extension TypingNumberView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanvasViewCell", for: indexPath) as! CanvasViewCell
        cell.value = indexPath.item + 1
        return cell
    }
}
