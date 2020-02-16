//
//  ResultsController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 15.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class ResultsController: UIViewController {
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        // Do any additional setup after loading the view.
    }
    

}
