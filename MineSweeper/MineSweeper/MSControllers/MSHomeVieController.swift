//
//  MSHomeVieController.swift
//  MineSweeper
//
//  Created by Mimosa on 2021/9/7.
//

import UIKit

class MSHomeVieController: UIViewController {
    
    var board: MSBoard!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        board = MSBoard()
        board.backgroundColor = .systemGray5
        view.addSubview(board)
        board.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }
    }

}
