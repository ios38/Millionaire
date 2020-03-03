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
    
    let questionsCaretaker = QuestionsCaretaker()
    private(set) var questions: [LocalQuestion] {
        didSet {
            questionsCaretaker.save(self.questions)
            print("GameSession: locaLQuestions.count: \(self.questions.count)")
        }
    }
    
    init() {
        questions = questionsCaretaker.load()
    }

}

extension GameSession: GameDelegate {
    func didLoadQuestion(_ question: LocalQuestion) {
        questions.append(question)
    }
    
    func trueAnswer() {
        trueAnswersCount.value += 1
    }
    
    func didEndGame() {
        print("GameSession: правильных ответов: \(trueAnswersCount.value)")
        Game.shared.endGame(with: trueAnswersCount.value)
    }
}
