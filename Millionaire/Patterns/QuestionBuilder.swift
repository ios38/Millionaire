//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Maksim Romanov on 03.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class QuestionBuilder {
    var type = 0
    var question = ""
    var answers = [String]()

    func build() -> LocalQuestion {
        return LocalQuestion(type: type, question: question, answers: answers)
    }

    func setType(_ type: Int) {
        self.type = type
    }

    func setQuestion(_ question: String) {
        self.question = question
    }

    func setAnswers(_ answers:[String]) {
        self.answers = answers
    }
}
