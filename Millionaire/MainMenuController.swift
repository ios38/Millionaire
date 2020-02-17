//
//  MainMenuController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    /*
    @IBAction func startButton(_ sender: UIButton) {
        performSegue(withIdentifier: "StartGame", sender: nil)
    }*/
    
    @IBAction func resultButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var lastResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "StartGame":
            guard let destination = segue.destination as? GameController else { return }
            //destination.gameDelegate = self
            destination.onGameEnd = { [weak self] result in
                let resultText = String(result)
                self?.lastResultLabel.text = "Правильных ответов: \(resultText)"
            }
        default:
            break
        }
    }
}
/*
extension MainMenuController: GameDelegate {
    func didEndGame(withResult result: Bool) {
        var resultText = ""
        switch result {
        case true:
            resultText = "Вы угадали!"
        default:
            resultText = "Вы не угадали!"
        }
        lastResultLabel.text = resultText
    }

}*/
