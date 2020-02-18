//
//  GameSession.swift
//  Millionaire
//
//  Created by Maksim Romanov on 18.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class GameSession {
    var result = 0
}

extension GameSession: GameDelegate {
    
    func startGame(_ mainMenu: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameController = storyboard.instantiateViewController(withIdentifier: "GameController") as! GameController
        gameController.modalPresentationStyle = .overFullScreen
        mainMenu.present(gameController, animated: false)

    }
    
    func didEndGame(withResult result: Int) {
        print("GameSession: правильных ответов: \(result)")
        Game.shared.endGame(with: result)
    }
}
