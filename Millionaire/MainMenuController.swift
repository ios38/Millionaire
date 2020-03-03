//
//  MainMenuController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {
    @IBOutlet weak var difficultyControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var lastResultLabel: UILabel!

    private var selectedDifficulty: Difficulty {
        switch self.difficultyControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .medium
        case 2:
            return .hard
        case 3:
            return .insane
        default:
            return .medium
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        startButton.addTarget(self, action: #selector(startSession), for: .touchUpInside)
        resultsButton.addTarget(self, action: #selector(showResults), for: .touchUpInside)
    }

    @objc func startSession(_ sender: Any) {
        Game.shared.gameSession = GameSession()
        Game.shared.gameSession?.difficulty = self.selectedDifficulty
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gameController = storyboard.instantiateViewController(withIdentifier: "GameController") as! GameController
        gameController.modalPresentationStyle = .overFullScreen
        present(gameController, animated: false)

    }

    @objc func showResults(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let resultsController = storyboard.instantiateViewController(withIdentifier: "ResultsController") as! ResultsController
        resultsController.modalPresentationStyle = .overFullScreen
        present(resultsController, animated: false)
    }
}
