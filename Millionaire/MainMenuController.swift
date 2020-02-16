//
//  MainMenuController.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {

    @IBAction func startButton(_ sender: UIButton) {
        performSegue(withIdentifier: "StartGame", sender: nil)
    }
    
    @IBAction func resultButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
    }
}
