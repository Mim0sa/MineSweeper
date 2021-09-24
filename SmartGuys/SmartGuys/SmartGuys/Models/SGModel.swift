//
//  SGModel.swift
//  SmartGuys
//
//  Created by Mimosa on 2021/9/24.
//

import Foundation

enum SGComplexityLevel {
    case Easy
}

struct SGBoardModel {
    
    let boardSize: (width: Int, height: Int)
    
    var cardModels: [[SGCardModel.CardStatus]] {
        willSet {
            if !isCardModelsValid(models: newValue) {
                fatalError("The cardModels is invalid!")
            }
        }
    }
    
    init(size: (width: Int, height: Int)) {
        if size.width < 3 || size.height < 3 { fatalError("The board size is too small!") }
        boardSize = size
        cardModels = Array(repeating: Array(repeating: .Covered(type: .Normal), count: boardSize.width), count: boardSize.height)
    }
    
    func isCardModelsValid(models: [[SGCardModel.CardStatus]]) -> Bool {
        if models.count != boardSize.height {
            return false
        }
        for list in models {
            if list.count != boardSize.width {
                return false
            }
        }
        return true
    }
    
}

struct SGBoardConfig {
    var boardSize: (width: Int, height: Int)
    var trapCount: Int
    var jokerCount: Int
}

struct SGCardModel {
    
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


