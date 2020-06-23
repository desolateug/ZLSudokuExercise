//
//  GridView.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/3.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    // MARK: - init
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
    }
    
    func prepareUI() {
        layer.borderColor = edgeLineUI.color
        layer.borderWidth = edgeLineUI.width
        backgroundColor = UIColor(hex: 0xF7FFA8)
    }
    
    // MARK: - properties
    
    var rowCount: Int = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var columnCount: Int = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var rank: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    // MARK: - draw
    
    private struct LineUI {
        let color: CGColor
        let width: CGFloat
    }
    
    private let edgeLineUI = LineUI(color: UIColor(hex: 0x1B1B24).cgColor, width: 2)
    private let commonLineUI = LineUI(color: UIColor(hex: 0xD1CECB).cgColor, width: 1)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context =  UIGraphicsGetCurrentContext()!
        let viewWidth = bounds.size.width
        let viewHeight = bounds.size.height
        let cellWidth = viewWidth/CGFloat(columnCount)
        let cellHeight = viewHeight/CGFloat(rowCount)
        
        func addLine(from: CGPoint, to: CGPoint, isBlockEdge: Bool) {
            context.setStrokeColor(isBlockEdge ? edgeLineUI.color : commonLineUI.color)
            context.setLineWidth(isBlockEdge ? edgeLineUI.width : commonLineUI.width)
            context.move(to: from)
            context.addLine(to: to)
            context.strokePath()
        }
        
        // row
        for row in 0...rowCount {
            let isBlockEdge = rank != 0 ? row%rank == 0 : false
            if !isBlockEdge {
                let y = cellHeight*CGFloat(row)
                addLine(from: CGPoint(x: 0, y: y), to: CGPoint(x: viewWidth, y: y), isBlockEdge: isBlockEdge)
            }
        }
        
        // column
        for column in 0...columnCount {
            let isBlockEdge = rank != 0 ? column%rank == 0 : false
            if !isBlockEdge {
                let x = cellWidth*CGFloat(column)
                addLine(from: CGPoint(x: x, y: 0), to: CGPoint(x: x, y: viewHeight), isBlockEdge: isBlockEdge)
            }
        }
        
        // block row
        for row in 0...rowCount {
            let isBlockEdge = rank != 0 ? row%rank == 0 : false
            if isBlockEdge {
                let y = cellHeight*CGFloat(row)
                addLine(from: CGPoint(x: 0, y: y), to: CGPoint(x: viewWidth, y: y), isBlockEdge: isBlockEdge)
            }
        }
        
        // block column
        for column in 0...columnCount {
            let isBlockEdge = rank != 0 ? column%rank == 0 : false
            if isBlockEdge {
                let x = cellWidth*CGFloat(column)
                addLine(from: CGPoint(x: x, y: 0), to: CGPoint(x: x, y: viewHeight), isBlockEdge: isBlockEdge)
            }
        }
    }

}
