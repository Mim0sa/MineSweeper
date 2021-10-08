//
//  SGCardModel.swift
//  SmartGuys
//
//  Created by Mimosa on 2021/10/8.
//

import Foundation

struct SGCardModel {
    
    var status: CardStatus
    
}

extension SGCardModel {
    enum CardStatus {
        case Covered(type: CardType)
        case Opened(type: CardType)
        case Hidden(type: CardType)
    }
    
    enum CardType {
        case Normal
        case Trap
        case Joker
    }
}
