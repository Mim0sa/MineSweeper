//
//  ViewController.swift
//  MineSweeper
//
//  Created by Mimosa on 2021/8/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    var boardView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.backgroundColor = .systemGray2
        contentView.addSubview(boardView)
        boardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(r:)))
        boardView.addGestureRecognizer(pinch)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(r:)))
        boardView.addGestureRecognizer(pan)
    }
    
    // max 1.6 min 0.6
    var pinchScale: CGFloat = 1
    
    @objc func pinch(r: UIPinchGestureRecognizer) {
        switch r.state {
        case .began:
            print("began")
            print(r.scale)
        case .changed:
            pinchScale = pinchScale + (r.scale - 1) / 2
            if pinchScale > 1.6 {
                pinchScale = 1.6
            } else if pinchScale < 0.6 {
                pinchScale = 0.6
            }
            boardView.transform = CGAffineTransform(scaleX: pinchScale, y: pinchScale).translatedBy(x: panOffset.x, y: panOffset.y)
            r.scale = 1
        case .ended:
            print("ended")
        default:
            print("UIPinchGestureRecognizer State Exceptions")
        }
    }
    
    var panOffset = CGPoint()
    
    @objc func pan(r: UIPanGestureRecognizer) {
        switch r.state {
        case .began:
            print("began")
        case .changed:
            let offset = r.translation(in: contentView)
            let newOffset = panOffset.offset(by: offset)
            if !contentView.frame.contains(boardView.frame) {
                // left
                
            } else {
                panOffset = newOffset
            }
            boardView.transform = CGAffineTransform(scaleX: pinchScale, y: pinchScale).translatedBy(x: panOffset.x, y: panOffset.y)
            r.setTranslation(CGPoint(), in: contentView)
        case .ended:
            print("ended")
        default:
            print("UIPanGestureRecognizer State Exceptions")
        }
    }

}

extension CGPoint {
    func offset(by p: CGPoint) -> CGPoint {
        CGPoint(x: x + p.x, y: y + p.y)
    }
}

extension CGRect {
    func offset(by p: CGPoint) -> CGRect {
        CGRect(x: origin.x + p.x, y: origin.y + p.y, width: width, height: height)
    }
}

