//
//  ViewController.swift
//  SmartGuys
//
//  Created by Mimosa on 2021/9/13.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let v = UIView()
        v.backgroundColor = .randomLSColor()
        v.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        view.addSubview(v)
        
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(g:))))
        
        let model = SGBoardModel(config: SGComplexityLevel.Hard.getConfig())
        print(model)
    }
    
    @objc func tap(g: UITapGestureRecognizer) {
        guard let v = g.view else { return }
        UIView.transition(with: v, duration: 1, options: .transitionFlipFromRight, animations: {
            v.backgroundColor = .randomLSColor()
        }, completion: nil)
    }

}

