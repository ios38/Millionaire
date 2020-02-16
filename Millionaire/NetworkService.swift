//
//  NetworkService.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    static let session: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: config)
        return session
    }()
    
    static func loadQuestion(qType: Int, completion: ((Swift.Result<QuestionAndAnswers, Error>) -> Void)? = nil) {
        let baseUrl = "https://lip2.xyz/api/millionaire.php"
        
        let params: Parameters = [
            "q": qType
        ]
        
        NetworkService.session.request(baseUrl, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                let dataJSON = json["data"]
                let item = QuestionAndAnswers(from: dataJSON)
                completion?(.success(item))
            case let .failure(error):
                completion?(.failure (error))
            }
        }
    }
}
