//
//  SudokuView.swift
//  SudokuSolver
//
//  Created by Hoang Tung on 11/13/19.
//  Copyright © 2019 Hoang Tung. All rights reserved.
//

import UIKit

class SudokuView: UIView {
    
    var radius: CGFloat = 0
    var boardTextField: [[UITextField]] = []
    var originBoard: [[Int]] = []

    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(
            frame: CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            )
        )
        self.center = center
        self.radius = radius
    }
    
    override func draw(_ rect: CGRect) {
        for line in 0...9 {
            let path1 = UIBezierPath()
            path1.move(to: CGPoint(x: self.bounds.maxX / 9 * CGFloat(line), y: 0))
            path1.addLine(to: CGPoint(x: self.bounds.maxX / 9 * CGFloat(line), y: self.bounds.maxY))
            let shape = CAShapeLayer()
            shape.path = path1.cgPath
            shape.strokeColor = UIColor.systemBlue.cgColor
            shape.lineWidth = 1
            
            let path2 = UIBezierPath()
            path2.move(to: CGPoint(x: 0, y: self.bounds.maxY / 9 * CGFloat(line)))
            path2.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY / 9 * CGFloat(line)))
            let shape2 = CAShapeLayer()
            shape2.path = path2.cgPath
            shape2.strokeColor = UIColor.systemBlue.cgColor
            shape2.lineWidth = 1
            
            if [0, 3, 6, 9].contains(line) {
                shape.lineWidth = 3
                shape2.lineWidth = 3
            }
            
            self.layer.addSublayer(shape)
            self.layer.addSublayer(shape2)
        }
    }
    
    func changeNumber(number: Int, row: Int, column: Int) {
        switch number {
        case 0:
            self.boardTextField[row][column].text = ""
        default:
            self.boardTextField[row][column].text = String(number)
            self.boardTextField[row][column].textColor = UIColor.systemRed
        }
    }
    
    func createSquare() {
        for row in 0...8 {
            self.boardTextField.append([])
            for column in 0...8 {
                let square = UITextField()
                square.frame = CGRect(
                    x: self.bounds.maxX / 9 * CGFloat(column),
                    y: self.bounds.maxY / 9 * CGFloat(row),
                    width: self.bounds.maxX / 9,
                    height: self.bounds.maxX / 9)
                square.textAlignment = .center
                square.text = ""
                self.boardTextField[row].append(square)
            }
        }
        
        for row in self.boardTextField {
            for square in row {
                self.addSubview(square)
            }
        }
    }
    
    func reset() {
        for i in 0...8 {
            for j in 0...8 {
                self.boardTextField[i][j].textColor = UIColor.black
                if self.originBoard[i][j] == 0 {
                    self.boardTextField[i][j].text = ""
                } else {
                    self.boardTextField[i][j].text = String(self.originBoard[i][j])
                }
            }
        }
    }
    
    func addOriginBoard(board: [[Int]]) {
        self.originBoard = board
        self.reset()
    }
    
    func createBoardValue() {
        for i in 0...8 {
            for j in 0...8 {
                if self.boardTextField[i][j].text == "0" {
                    self.originBoard[i][j] = 0
                } else {
                    self.originBoard[i][j] =  Int(String(self.boardTextField[i][j].text!)) ?? 0
                }
            }
        }
    }
    
    func new() {
        self.originBoard = [
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
        ]
        self.reset()
    }
}
