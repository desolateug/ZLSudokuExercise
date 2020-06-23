//
//  UIColor+Ex.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/3.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, opaque: Bool = true) {
        var hexValue = hex
        var rgba = [CGFloat]()
        for _ in 1...(opaque ? 3: 4) {
            let value = CGFloat(hexValue & 0xFF) / 255.0
            rgba.insert(value, at: 0)
            hexValue >>= 8
        }
        if opaque {
            rgba.append(1)
        }
        self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
    
    convenience init?(hex: String) {
        var colorHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (colorHex.hasPrefix("#")) {
            colorHex.remove(at: colorHex.startIndex)
        }
        guard colorHex.count == 6 || colorHex.count == 8 else {
            return nil
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorHex).scanHexInt32(&rgbValue)
        self.init(hex: Int(rgbValue), opaque: colorHex.count == 6)
    }
}
