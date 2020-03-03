//
//  QuestionStrategy.swift
//  Millionaire
//
//  Created by Maksim Romanov on 02.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class QuestionStrategy {
    
    func getQuestionDifficulty() -> Int {
        guard let difficulty = Game.shared.gameSession?.difficulty else { return 1 }
        switch difficulty {
        case .easy:
            return 1
        case .medium:
            return mediumDifficulty()
        case .hard:
            return hardDifficulty()
        case .insane:
            return 3
        }
        
    }
    
    func mediumDifficulty() -> Int {
        guard let trueAnswersCount = Game.shared.gameSession?.trueAnswersCount else { return 1 }
        switch trueAnswersCount.value {
        case 0...4:
            return 1
        case 5...9:
            return 2
        case 10...:
            return 3
        default:
            return 1
        }
    }

    func hardDifficulty() -> Int {
        guard let trueAnswersCount = Game.shared.gameSession?.trueAnswersCount else { return 1 }
        switch trueAnswersCount.value {
        case 0...4:
            return 2
        case 5...9:
            return 3
        case 10...:
            return 3
        default:
            return 1
        }
    }

}
