//
//  QuestionsCaretaker.swift
//  Millionaire
//
//  Created by Maksim Romanov on 03.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class QuestionsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "questions"
    
    func save(_ questions: [LocalQuestion]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func load() -> [LocalQuestion] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([LocalQuestion].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
