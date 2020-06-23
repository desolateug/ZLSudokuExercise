//
//  NVActivityIndicatorPresenter+Ex.swift
//  ZLSudokuExercise
//
//  Created by zlj on 2020/3/4.
//  Copyright © 2020 zlj. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HUD {
    static func showLoading() {
        let activityData = ActivityData(displayTimeThreshold: 100)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
