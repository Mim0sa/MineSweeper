//
//  SGBoardModel.swift
//  SmartGuys
//
//  Created by Mimosa on 2021/9/24.
//

import Foundation

enum SGComplexityLevel {
    case Easy
    case Medium
    case Hard
    case Custom(config: SGBoardConfig)
    
    func getConfig() -> SGBoardConfig {
        switch self {
        case .Easy:
            return SGBoardConfig(boardSize: (3, 3), trapCount: 1, jokerCount: 1)
        case .Medium:
            return SGBoardConfig(boardSize: (4, 4), trapCount: 1, jokerCount: 3)
        case .Hard:
            return SGBoardConfig(boardSize: (5, 5), trapCount: 1, jokerCount: 5)
        case .Custom(config: let config):
            return config
        }
    }
}

struct SGBoardConfig {
    var boardSize: (width: Int, height: Int)
    var trapCount: Int
    var jokerCount: Int
}

struct SGBoardModel {
    
    let config: SGBoardConfig
    
    var cardModels: [[SGCardModel]] {
        willSet {
            if !isCardModelsValid(models: newValue) {
                fatalError("The cardModels is invalid!")
            }
        }
    }
    
    init(config: SGBoardConfig) {
        self.config = config
        cardModels = Array(repeating: Array(repeating: SGCardModel(status: .Covered(type: .Normal)),
                                            count: config.boardSize.width),
                           count: config.boardSize.height)
    }
    
    func isCardModelsValid(models: [[SGCardModel]]) -> Bool {
        if models.count != config.boardSize.height {
            return false
        }
        for list in models {
            if list.count != config.boardSize.width {
                return false
            }
        }
        return true
    }
    
}

