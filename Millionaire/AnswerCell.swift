//
//  AnswerCell.swift
//  Millionaire
//
//  Created by Maksim Romanov on 14.02.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        answerView.layer.borderWidth = 2
        answerView.layer.borderColor = UIColor.white.cgColor
        answerView.layer.cornerRadius = 10
        //answerView.layer.backgroundColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
