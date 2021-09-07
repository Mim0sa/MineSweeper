//
//  MSBoard.swift
//  MineSweeper
//
//  Created by Mimosa on 2021/9/6.
//

import UIKit

class MSBoard: UIView {
        
    var model: MSBoardModel!

    init() {
        super.init(frame: CGRect())
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(r:)))
        addGestureRecognizer(pinch)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(r:)))
        addGestureRecognizer(pan)
        
    }
    
    // max 1.6 min 1
    var pinchScale: CGFloat = 1
    var panOffset = CGPoint()
    var panControlRect = CGRect()
    
    @objc func pinch(r: UIPinchGestureRecognizer) {
        switch r.state {
        case .began, .changed:
            pinchScale = pinchScale + (r.scale - 1) / 2
            if pinchScale > 1.6 {
                pinchScale = 1.6
            } else if pinchScale < 1 {
                pinchScale = 1
            }
            transform = CGAffineTransform(scaleX: pinchScale, y: pinchScale).translatedBy(x: panOffset.x, y: panOffset.y)
            r.scale = 1
        case .ended:
            break
        default:
            print("UIPinchGestureRecognizer State Exceptions")
        }
    }
    
    @objc func pan(r: UIPanGestureRecognizer) {
        switch r.state {
        case .began, .changed:
            let offset = r.translation(in: superview)
            let newOffset = panOffset.offset(by: offset)
            panOffset = newOffset
            transform = CGAffineTransform(scaleX: pinchScale, y: pinchScale).translatedBy(x: panOffset.x, y: panOffset.y)
            r.setTranslation(CGPoint(), in: superview)
        case .ended:
            break
        default:
            print("UIPanGestureRecognizer State Exceptions")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
