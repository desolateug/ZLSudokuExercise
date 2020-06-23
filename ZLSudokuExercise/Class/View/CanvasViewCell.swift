//
//  CanvasViewCell.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/2.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit
import SnapKit

class CanvasViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        backgroundView = UIView()
        backgroundView?.isHidden = true
        backgroundView?.backgroundColor = UIColor(hex: 0xFFE25E)
        backgroundView!.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }
    }
    
    var value: Int = 0 {
        didSet {
            textLabel.text = value != 0 ? "\(value)" : ""
        }
    }
    
    var selectedState: Bool = false {
        didSet {
            backgroundView?.isHidden = !selectedState
        }
    }
    
    var highlightedState: Bool = false {
        didSet {
            textLabel.textColor = highlightedState ? UIColor.red : UIColor.black
        }
    }
    
    // MARK: - lazy
    
    fileprivate var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
}
