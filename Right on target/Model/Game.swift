//
//  Game.swift
//  Right on target
//
//  Created by mac on 27.07.2021.
// сущность "игра"

import Foundation

// протокол, определяющий требования к классу Game
protocol GameProtocol {
    associatedtype SecretType
    
//    кол-во заработанных очков
    var score: Int { get }
    
//    секретное число
    var secretValue: SecretType { get }
    
//    проверка окончания игры
    var isGameEnded: Bool { get }
    
//    начинает новую игру и сразу стартует первый раунд
    func restartGame()
    
//    начинает новый раунд 
    func startNewRoud()
    
//    сравнение значения пользователя с загаданным и подсчет очков
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    
    typealias SecretType = T
    var score: Int = 0
    
//    секретное значение
    var secretValue: T
    
//    замыкание производит сравнение значений и возвращает заработанные очки
    private var compareClosure: (T, T) -> Int
    private var roundsCount: Int!
    private var currentRoundNumber: Int = 0
    var isGameEnded: Bool {
        if currentRoundNumber == roundsCount {
            return true
        } else {
            return false
        }
    }
    
    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRoud()
    }
    
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRoud()
    }
    
    func startNewRoud() {
        currentRoundNumber += 1
        self.secretValue.setRandomValue()
    }
    
    func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure(secretValue, userValue)
    }
    
}
