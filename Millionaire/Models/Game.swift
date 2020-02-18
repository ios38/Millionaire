//
//  Game.swift
//  Millionaire
//
//  Created by Maksim Romanov on 18.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class Game {
    static let shared = Game()
    var gameSession: GameSession?
    private(set) var gameResults: [GameResult] = []
    
    private init() {}
    
    func endGame(with result: Int) {
        let date = Date()
        let newResult = GameResult(date: date, result: result)
        gameResults.append(newResult)
        print("Game: gameResults: \(gameResults)")
        gameSession = nil
    }
}

