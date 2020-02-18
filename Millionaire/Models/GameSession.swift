//
//  GameSession.swift
//  Millionaire
//
//  Created by Maksim Romanov on 18.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class GameSession {
    var result = 0
}

extension GameSession: GameDelegate {
    func didEndGame(withResult result: Int) {
        print("GameSession: правильных ответов: \(result)")
        Game.shared.endGame(with: result)
    }
}
