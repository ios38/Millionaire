//
//  ResultsController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 15.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class ResultsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var resultsTable: UITableView!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTable.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let results = Game.shared.results.sorted(by: {$0.date > $1.date} )
        let result = results[indexPath.row]
        cell.textLabel?.text = "\(dateFormatter.string(from: result.date)) - \(result.result)"
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
}
