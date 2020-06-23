//
//  CanvasView.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/2.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

class CanvasView: GridView {
    
    override func prepareUI() {
        super.prepareUI()
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        updateUI()
    }
    
    private func updateUI() {
        rank = sample?.rank ?? 3
        rowCount = sample?.maxNum ?? 9
        columnCount = sample?.maxNum ?? 9
    }
    
    private var dataSource: [[Int]] {
        if let sample = sample {
            return sample.dataSource
        }
        return [[Int]]()
    }
    
    // MARK: - public
    
    var sample: Sample? {
        didSet {
            updateUI()
            reloadData()
        }
    }
    
    var highlightIndexPaths = [IndexPath]() {
        didSet {
            reloadData()
        }
    }
    
    var selectedIndexPath: IndexPath?
    
    func reloadData() {
        collectionView.reloadData()
    }
    
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

extension CanvasView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/CGFloat(dataSource[indexPath.section].count)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
    }
}

extension CanvasView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanvasViewCell", for: indexPath) as! CanvasViewCell
        cell.value = dataSource[indexPath.section][indexPath.item]
        cell.selectedState = selectedIndexPath == indexPath
        cell.highlightedState = highlightIndexPaths.contains(indexPath)
        return cell
    }
}
