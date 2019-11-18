//
//  File.swift
//  SudokuSolver
//
//  Created by Hoang Tung on 11/13/19.
//  Copyright © 2019 Hoang Tung. All rights reserved.
//

import Foundation

class SudokuSolver {
    
    struct Position {
        let row: Int
        let column: Int
    }
    
    struct Step {
        let number: Int
        let row: Int
        let column: Int
    }
    
    var board: [[Int]]
    var rowIndex: Int
    var columnIndex: Int
    var number: Int
    
    var defaultBoard: [[Int]] = [
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
    
    var steps: [Step] = []
    var indexStep: Int
    
    init() {
        self.board = []
        self.rowIndex = 0
        self.columnIndex = 0
        self.number = 0
        self.steps = []
        self.indexStep = 0
    }
    
    func addBoard(board: [[Int]]) {
        self.board = board
    }
    
    func solve() -> Bool {
        guard let pos = self.findEmpty() else {
            return true
        }
        
        for number in 1...9 {
            if self.checkValid(number: number, pos: pos) {
                self.board[pos.row][pos.column] = number
                self.steps.append(Step(number: number, row: pos.row, column: pos.column))
                
                if solve() {
                    return true
                }
                
                self.board[pos.row][pos.column] = 0
                self.steps.append(Step(number: 0, row: pos.row, column: pos.column))
            }
        }
        
        return false
    }
    
    func findEmpty() -> Position? {
        for (rowIndex, _) in self.board.enumerated() {
            for (columnIndex, _) in self.board[0].enumerated() {
                if self.board[rowIndex][columnIndex] == 0 {
                    return Position(row: rowIndex, column: columnIndex)
                }
            }
        }
        return nil
    }
    
    func checkRow(_ number: Int, _ pos: Position) -> Bool {
        for (columnIndex, _) in self.board[0].enumerated() {
            if self.board[pos.row][columnIndex] == number && pos.column != columnIndex {
                return false
            }
        }
        return true
    }
    
    func checkColumn(_ number: Int, _ pos: Position) -> Bool {
        for (rowIndex, _) in self.board.enumerated() {
            if self.board[rowIndex][pos.column] == number && pos.row != rowIndex {
                return false
            }
        }
        return true
    }
    
    func checkBox(_ number: Int, _ pos: Position) -> Bool {
        let box_x = Int((Float(pos.column) / 3).rounded(.down) * 3)
        let box_y = Int((Float(pos.row) / 3).rounded(.down) * 3)
        for rowIndex in box_y..<(box_y + 3) {
            for columnIndex in box_x..<(box_x + 3) {
                if self.board[rowIndex][columnIndex] == number
                    && (pos.row, pos.column) != (rowIndex, columnIndex) {
                    return false
                }
            }
        }
        return true
    }
    
    func checkValid(number: Int, pos: Position) -> Bool {
        if !self.checkRow(number, pos) || !self.checkColumn(number, pos) || !self.checkBox(number, pos) {
            return false
        }
        return true
    }
    
    func reset() {
        self.indexStep = 0
        self.board = self.defaultBoard
        self.steps = []
        
    }
    
    func next() -> Step? {
        if self.indexStep == self.steps.count {
            return nil
        }
        
        let step = self.steps[self.indexStep]
        self.indexStep += 1
        return step
    }
}
