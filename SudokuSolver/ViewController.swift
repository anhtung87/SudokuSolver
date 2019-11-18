//
//  ViewController.swift
//  SudokuSolver
//
//  Created by Hoang Tung on 11/13/19.
//  Copyright © 2019 Hoang Tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sudokuView: SudokuView!
    @IBOutlet weak var startButton: StartButton!
    
    var timer: Timer!
    var sudoku: SudokuSolver!
    var indexStep: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sudoku = SudokuSolver()
        
        sudokuView.createSquare()
        self.addBoardToUIView()
    }
    
    @objc func runTimer() {
        guard let step = self.sudoku.next() else {
            timer.invalidate()
            return
        }
        
        sudokuView.changeNumber(number: step.number, row: step.row, column: step.column)
    }
    
    func addBoardToUIView() {
        self.sudokuView.reset()
    }
    
    @IBAction func onPress(_ sender: Any) {
        if self.startButton.titleLabel?.text == "Start" {
            self.sudokuView.createBoardValue()
            sudoku.addBoard(board: self.sudokuView.originBoard)
            let _: Bool = self.sudoku.solve()
            self.timer = Timer.scheduledTimer(
                timeInterval: 0.05, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
        } else if self.startButton.titleLabel?.text == "Reset" {
            self.timer.invalidate()
            self.sudokuView.reset()
            self.sudoku.reset()
        }
        startButton.changeTitle()
    }
}
