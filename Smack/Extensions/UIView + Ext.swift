//
//  UIView + Ext.swift
//  Smack
//
//  Created by Alex Lebedev on 20.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
  func startBluring(style: UIBlurEffect.Style) {
    var blurEffectView = UIVisualEffectView()
    let blurEffect = UIBlurEffect(style: style)
    blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    addSubview(blurEffectView)
  }
  
  func stopBluring() {
    for view in self.subviews {
      if let view = view as? UIVisualEffectView {
        view.removeFromSuperview()
      }
    }
  }
    func addActivityIndicator(){
        var AI = UIActivityIndicatorView()
        AI.startAnimating()
        addSubview(AI)
    }
}
