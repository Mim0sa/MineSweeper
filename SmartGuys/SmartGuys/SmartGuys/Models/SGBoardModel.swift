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
        let indexs = getRandomIndexs(count: config.trapCount + config.jokerCount).shuffled()
        for i in 0...config.trapCount - 1 {
            cardModels[indexs[i].0][indexs[i].1].status = .Covered(type: .Trap)
        }
        for i in 0...config.jokerCount - 1 {
            cardModels[indexs[i + config.trapCount].0][indexs[i + config.trapCount].1].status = .Covered(type: .Joker)
        }
    }
    
    mutating func swapCards(index1: (Int, Int), index2: (Int, Int)) {
        let model = cardModels[index1.0][index1.1]
        cardModels[index1.0][index1.1] = cardModels[index2.0][index2.1]
        cardModels[index2.0][index2.1] = model
    }
    
    mutating func flipCards(index: (Int, Int)) {
//        switch cardModels[index.0][index.1].status {
//        case .Covered(type: let type):
//            <#code#>
//        case .Opened(type: let type):
//            <#code#>
//        case .Hidden(type: let type):
//            <#code#>
//        }
    }
    
    func getRandomIndexs(count: Int = 1) -> [(Int, Int)] {
        var indexs: [(Int, Int)] = []
        
        func getRandomIndex() -> (Int, Int) {
            let randomX = Int.random(in: 0...config.boardSize.width - 1)
            let randomY = Int.random(in: 0...config.boardSize.height - 1)
            for index in indexs {
                if index.0 == randomX && index.1 == randomY {
                    return getRandomIndex()
                }
            }
            return (randomX, randomY)
        }
        
        for _ in 0...count - 1 {
            let index = getRandomIndex()
            indexs.append(index)
        }
        
        return indexs // indexs are in order
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

extension SGBoardModel: CustomStringConvertible {
    
    var description: String {
        if cardModels.isEmpty { return "" }
        
        let sep = " ---------------"
        var string = ""
        
        for modelList in cardModels {
            for _ in modelList {
                string.append(sep)
            }
            string.append("\n")
            for model in modelList {
                string.append("| \(stringWith(model.status)) ")
            }
            string.append("|\n")
        }
        for _ in cardModels.last! {
            string.append(sep)
        }
        
        let pre = "| SGBoardModel -> (width: \(config.boardSize.width), height: \(config.boardSize.height), trap: \(config.trapCount), joker: \(config.jokerCount))\n"
        string = pre + string
        
        return string
    }
    
    func stringWith(_ status: SGCardModel.CardStatus) -> String {
        var str = ""
        switch status {
        case .Covered(type: let type):
            str.append("Coverd.\(type.rawValue)")
        case .Opened(type: let type):
            str.append("Opened.\(type.rawValue)")
        case .Hidden(type: let type):
            str.append("Hidden.\(type.rawValue)")
        }
        return str
    }
    
}

