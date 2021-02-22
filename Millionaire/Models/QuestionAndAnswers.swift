//
//  QuestionAndAnswers.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionAndAnswers {
    var question = ""
    var answers = [String]()

    init(_ question: String, _ answers: [String]) {
        self.question = question
        self.answers = answers
    }

    init(from json: JSON) {
        question = json["question"].stringValue
        let answersJSON = json["answers"].arrayValue
        answers = answersJSON.map { $0.stringValue }
        //answers = jsonToString(answersJSON)
    }
}
