//
//  Result.swift
//  calculator
//
//  Created by Гриша on 19.01.17.
//  Copyright © 2017 ru.sapgv. All rights reserved.
//

import Foundation

func evalRPN(tokens: [String]) -> Double {
    var stack = [String]()
    for s in tokens {
        switch s {
        case "+":
            let rightOperand = Double(stack.removeLast())!
            let leftOperand = Double(stack.removeLast())!
            stack.append(String(leftOperand + rightOperand))
        case "-":
            let rightOperand = Double(stack.removeLast())!
            let leftOperand = Double(stack.removeLast())!
            stack.append(String(leftOperand - rightOperand))
        case "*":
            let rightOperand = Double(stack.removeLast())!
            let leftOperand = Double(stack.removeLast())!
            stack.append(String(leftOperand * rightOperand))
        case "/":
            let rightOperand = Double(stack.removeLast())!
            let leftOperand = Double(stack.removeLast())!
            stack.append(String(leftOperand / rightOperand))
        default:
            stack.append(s)
        }
    }
    return Double(stack.removeLast())!
}

func tokenIsNumeric(token: String) -> Bool {
    
    let num = Double(token)
    if num != nil {
        return true
    }
    return false
}

func tokenIsOperation(token: String) -> Bool {
    
    let operation = "+-*/^()"
    return operation.containsString(token)
    
}
func evaluate(tokens: [String]) -> Double {
    
    var stack = [String]()
    let arrayOperation = ["*","/","+","-","^","u"]
    
    for token in tokens {
        
        
        if arrayOperation.contains(token) {
            
            
            if stack.count < 2 && token != "u" {
                print("недостаточна данных в стеке для операции")
            }
            
            if token == "u" {
                let b = Double(stack.popLast()!)!
                let res = b * (-1)
                stack.append(String(res))
                continue
            }
            
            let b = Double(stack.popLast()!)!
            let a = Double(stack.popLast()!)!
            var res = 0.0
            switch token {
                
            case "*":
                res = a * b
                break
                
            case "/":
                res = a / b
                break
                
            case "+":
                res = a + b
                break
                
            case "-":
                res = a - b
                break
                
            case "^":
                res = pow(a, b)
                break
                
            default:
                break
            }
            
            stack.append(String(res))
            
        }
        else if tokenIsNumeric(token) {
            stack.append(String(token))
        }
        else {
            print("Недопустимый символ в выражении: token")
        }
        
    }
    if stack.count > 1 {
        print("Количество операторов не соответствует количеству операндов")
    }
    
    return Double(stack.popLast()!)!
    
}
