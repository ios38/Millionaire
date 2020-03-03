//
//  LocalQuestion.swift
//  Millionaire
//
//  Created by Maksim Romanov on 03.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

struct LocalQuestion: Decodable, Encodable {
    var type = 0
    var question = ""
    var answers = [String]()
    
}
