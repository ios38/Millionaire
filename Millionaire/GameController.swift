//
//  GameController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

protocol GameDelegate: class {
    func didEndGame(withResult result: Int)
}

class GameController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var gameDelegate: GameDelegate?
    var onGameEnd: ((Int)->Void)?
    @IBOutlet weak var questionDifficulty: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTable: UITableView!
    @IBOutlet weak var fiftyFiftyButton: UIButton!
    
    var questionAndAnswers = QuestionAndAnswers("Загружаю вопрос...", ["","","",""])
    var trueAnswer = ""
    var trueAnswerColor  = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
    var falseAnswerColor  = UIColor(red: 100/255, green: 0/255, blue: 0/255, alpha: 1.0)
    var defaultColor  = UIColor.black
    var trueAnswersCount = 0
    var questionsType = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        questionTable.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        fiftyFiftyButton.addTarget(self, action: #selector(fiftyFiftyAnswers), for: .touchUpInside)
        gameDelegate = Game.shared.gameSession
        loadquestionAndAnswers()
    }
    
    func loadquestionAndAnswers() {
        questionsType = getQuestionType()
        NetworkService.loadQuestion(qType: questionsType) { result in
            switch result {
            case let .success(data):
                self.questionAndAnswers = data
                self.trueAnswer = data.answers[0]
                self.questionAndAnswers.answers.shuffle()
                DispatchQueue.main.async {
                    self.questionDifficulty.text = "Уровень сложности: \(self.questionsType)"
                    self.questionLabel.text = data.question
                    self.questionTable.reloadData()
                }

            case let .failure(error):
                print(error)
            }
        }
    }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionAndAnswers.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = questionTable.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as? AnswerCell else {
            preconditionFailure("AlbumsCell cannot be dequeued")
        }
        
        cell.answerLabel.text = self.questionAndAnswers.answers[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.allowsSelection = false
        let cell = tableView.cellForRow(at: indexPath) as! AnswerCell
        //var result: Bool
        if cell.answerLabel.text == trueAnswer {
            trueAnswersCount += 1
            //result = true
            cell.answerView.layer.backgroundColor = trueAnswerColor.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cell.answerView.layer.backgroundColor = self.defaultColor.cgColor
                self.loadquestionAndAnswers()
                tableView.allowsSelection = true
            }
        } else {
            //result = false
            cell.answerView.layer.backgroundColor = falseAnswerColor.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let row = self.rowWithTrueAnswer() else { return }
                let trueIndexPath = IndexPath(row: row, section: 0)
                let trueCell = tableView.cellForRow(at: trueIndexPath) as! AnswerCell
                trueCell.answerView.layer.backgroundColor = self.trueAnswerColor.cgColor
                self.gameDelegate?.didEndGame(withResult: self.trueAnswersCount)
                self.onGameEnd?(self.trueAnswersCount)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    func rowWithTrueAnswer() -> Int? {
        for i in 0...3 {
            if questionAndAnswers.answers[i] == trueAnswer {
                return i
            }
        }
        return nil
    }
    
    func getQuestionType() -> Int {
        switch self.trueAnswersCount {
        case 0...2:
            return 1
        case 3...5:
            return 2
        case 6...:
            return 3
        default:
            return 1
        }
    }
    
    @objc func fiftyFiftyAnswers(_ sender: Any) {
        var falseAnswers = questionAndAnswers.answers.filter { $0 != trueAnswer }
        questionAndAnswers.answers.removeAll(where: { $0 != trueAnswer })
        falseAnswers.shuffle()
        guard let randomAnswer = falseAnswers.first else { return }
        questionAndAnswers.answers.append(randomAnswer)
        questionAndAnswers.answers.shuffle()
        self.fiftyFiftyButton.isHidden = true
        questionTable.reloadData()
    }

}
