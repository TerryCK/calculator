//
//  CalculatorBrain.swift
//  calculator
//
//  Created by 陳 冠禎 on 2017/5/25.
//  Copyright © 2017年 陳 冠禎. All rights reserved.
//

import Foundation


func changesign(value: Double) -> Double {
    return -value
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        case clear
        
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi), //Double.pi,
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation(changesign),
        "×" : Operation.binaryOperation{$0 * $1},
        "+" : Operation.binaryOperation{$0 + $1},
        "-" : Operation.binaryOperation{$0 - $1}, // closure with simplist
        
        "=" : Operation.equals,
        "clr" : Operation.clear,
        "÷" : Operation.binaryOperation({ (r1: Double, r2: Double) -> Double in
            return r1 / r2
        }) // closure with detail
        
        
//  also
//        "÷" : Operation.binaryOperation({ (r1, r2)  in
//            return r1 / r2
//        }),
        
//        "÷" : Operation.binaryOperation( return r1 / r2 }),

        
        
        
        
        
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let constant = operations[symbol] {
            switch constant {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if let value = accumulator{
                    accumulator = function(value)
                }
                
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            
            case .clear:
                accumulator = nil
                pendingBinaryOperation = nil
            }
            
        }
    }
    
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    
    
    private struct PendingBinaryOperation {
        let function : (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        
    }
    
    var result: Double? {
        get {
            return accumulator ?? 0
        }
    }
}
