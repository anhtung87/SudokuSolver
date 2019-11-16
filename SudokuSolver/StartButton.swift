//
//  StartButton.swift
//  SudokuSolver
//
//  Created by Hoang Tung on 11/14/19.
//  Copyright © 2019 Hoang Tung. All rights reserved.
//

import UIKit

class StartButton: UIButton {
    
    var _title: String = "Start"
    var _backgroundColor: UIColor {
        return self.backgroundColor!
    }
    
    convenience init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: center.x, y: center.y, width: width, height: height))
        self.layer.cornerRadius = height / 2
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func changeTitle() {
        self._title = self._title == "Start" ? "Reset" : "Start"
        self.setTitle(self._title   , for: .normal)
    }

}
