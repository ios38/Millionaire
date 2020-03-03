//
//  GameSession.swift
//  Millionaire
//
//  Created by Maksim Romanov on 18.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class GameSession {
    var difficulty: Difficulty = .medium
    var trueAnswersCount = Observable<Int>(0)
}

extension GameSession: GameDelegate {
    /*
    func startGame(_ mainMenu: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameController = storyboard.instantiateViewController(withIdentifier: "GameController") as! GameController
        gameController.modalPresentationStyle = .overFullScreen
        mainMenu.present(gameController, animated: false)

    }*/
    func trueAnswer() {
        trueAnswersCount.value += 1
    }
    
    func didEndGame() {
        print("GameSession: правильных ответов: \(trueAnswersCount)")
        Game.shared.endGame(with: trueAnswersCount.value)
    }
}
