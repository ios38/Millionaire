//
//  GameController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

protocol GameDelegate: class {
    func trueAnswer()
    func didEndGame()
}

class GameController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    weak var gameDelegate: GameDelegate?
    //var onGameEnd: ((Int)->Void)?
    
    @IBOutlet weak var questionDifficultyLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTable: UITableView!
    @IBOutlet weak var fiftyFiftyButton: UIButton!
    @IBOutlet weak var trueAnswersCountLabel: UILabel!
        
    var questionAndAnswers = QuestionAndAnswers("Загружаю вопрос...", ["","","",""])
    var trueAnswer = ""
    var trueAnswersCount = 0
    var questionsType = 1
    var trueAnswerColor  = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
    var falseAnswerColor  = UIColor(red: 100/255, green: 0/255, blue: 0/255, alpha: 1.0)
    var defaultColor  = UIColor.black

    var countdownSeconds = 10
    var currentCountdownSeconds = 0
    var countdownTimer = Timer()
    let timerDispatchGroup = DispatchGroup() // Init DispatchGroup
    
    let questionStrategy = QuestionStrategy()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        questionTable.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "AnswerCell")
        fiftyFiftyButton.addTarget(self, action: #selector(fiftyFiftyAnswers), for: .touchUpInside)
        fiftyFiftyButton.layer.borderWidth = 2
        fiftyFiftyButton.layer.borderColor = UIColor.white.cgColor
        fiftyFiftyButton.layer.cornerRadius = 10
        trueAnswersCountLabel.text = "Правильных ответов: \(trueAnswersCount)"
        gameDelegate = Game.shared.gameSession
        loadQuestionAndAnswers()
    }
    
    func loadQuestionAndAnswers() {
        questionsType = questionStrategy.getQuestionDifficulty()
        NetworkService.loadQuestion(qType: questionsType) { result in
            switch result {
            case let .success(data):
                self.questionAndAnswers = data
                self.trueAnswer = data.answers[0]
                self.questionAndAnswers.answers.shuffle()
                DispatchQueue.main.async {
                    self.questionDifficultyLabel.text = "Уровень сложности: \(self.questionsType)"
                    self.questionLabel.text = data.question
                    self.questionTable.reloadData()
                    self.startTimer(countdownSeconds: self.countdownSeconds)
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
            countdownTimer.invalidate()
            self.gameDelegate?.trueAnswer()
            trueAnswersCount += 1
            trueAnswersCountLabel.text = "Правильных ответов: \(trueAnswersCount)"
            //result = true
            cell.answerView.layer.backgroundColor = trueAnswerColor.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cell.answerView.layer.backgroundColor = self.defaultColor.cgColor
                self.loadQuestionAndAnswers()
                tableView.allowsSelection = true
            }
        } else {
            //result = false
            countdownTimer.invalidate()
            cell.answerView.layer.backgroundColor = falseAnswerColor.cgColor
            gameCompletion()
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let row = self.rowWithTrueAnswer() else { return }
                let trueIndexPath = IndexPath(row: row, section: 0)
                let trueCell = tableView.cellForRow(at: trueIndexPath) as! AnswerCell
                trueCell.answerView.layer.backgroundColor = self.trueAnswerColor.cgColor
                self.gameDelegate?.didEndGame()
                //self.onGameEnd?(self.trueAnswersCount)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss(animated: false, completion: nil)
                }
            }*/
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

    @objc func fiftyFiftyAnswers(_ sender: Any) {
    let falseAnswers = questionAndAnswers.answers.filter { $0 != trueAnswer }
    questionAndAnswers.answers.removeAll(where: { $0 != trueAnswer })
    guard let randomAnswer = falseAnswers.randomElement() else { return }
    questionAndAnswers.answers.append(randomAnswer)
    self.fiftyFiftyButton.isHidden = true
    questionTable.reloadData()
    }

    func startTimer(countdownSeconds: Int) {
        if countdownSeconds != 0 {
            currentCountdownSeconds = countdownSeconds
            //timerDispatchGroup.enter() // Enter DispatchGroup
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleCountdown), userInfo: nil, repeats: true)
        }
    }

    @objc func handleCountdown() {
        //previewView.countdownLabel.text = "\(currentCountdownSeconds)"
        currentCountdownSeconds -= 1
        print(currentCountdownSeconds)
        if currentCountdownSeconds == 0 {
            countdownTimer.invalidate()
            //print("Время закончилось!")
            //timerDispatchGroup.leave() // Leave DispatchGroup
        }
    }
    
    func gameCompletion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let row = self.rowWithTrueAnswer() else { return }
            let trueIndexPath = IndexPath(row: row, section: 0)
            let trueCell = self.questionTable.cellForRow(at: trueIndexPath) as! AnswerCell
            trueCell.answerView.layer.backgroundColor = self.trueAnswerColor.cgColor
            self.gameDelegate?.didEndGame()
            //self.onGameEnd?(self.trueAnswersCount)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
