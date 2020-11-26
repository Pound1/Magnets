//
//  UILabelExtensions.swift
//  Matchday
//
//  Created by Lachy Pound on 6/8/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

extension UILabel {
    func addCharacterSpacing ( _ value: CGFloat = 10){
        if let textString = text {
            let attributes: [NSAttributedString.Key : Any] = [.kern: value]
            attributedText = NSAttributedString(string: textString, attributes: attributes)
        }
    }
}


extension UIView {
    func addDashedLineView(frame: CGRect) {
        
        let border = CAShapeLayer()
        border.strokeColor = UIColor.black.cgColor
        border.lineWidth = 2
        border.lineDashPattern = [8, 4]
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)//self.frame
        border.fillColor = UIColor.clear.cgColor
        border.lineJoin = CAShapeLayerLineJoin.round
        border.fillColor = nil
        border.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), cornerRadius: 20).cgPath
        self.clipsToBounds = true
        
        self.layer.addSublayer(border)
    }
}

extension CALayer {
    func slideInLabelAnimation(duration:CFTimeInterval){
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.type = .push
        animation.subtype = .fromLeft
        self.add(animation, forKey: nil)
    }
}
