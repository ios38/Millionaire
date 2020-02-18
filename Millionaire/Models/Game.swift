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
    private let resultsCaretaker = ResultsCaretaker()
    private(set) var results: [GameResult] {
        didSet {
            resultsCaretaker.save(results: self.results)
        }
    }
    
    private init() {
        results = resultsCaretaker.load()
    }
    
    func endGame(with result: Int) {
        let date = Date()
        let newResult = GameResult(date: date, result: result)
        results.append(newResult)
        gameSession = nil
    }
}

