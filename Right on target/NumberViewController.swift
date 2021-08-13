//
//  ViewController.swift
//  Right on target
//
//  Created by mac on 15.07.2021.
//

import UIKit

class NumberViewController: UIViewController {
    
// экземпляр игры с числами
    var game: Game<SecretNumericValue>!
    
    
//    элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var secretValueLabel: UILabel!

    
//    MARK: - жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        
//        обновляем данные о текущем значении загаднного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    
//    MARK: - взаимодействие View - Model
    
//    проверка выбранного пользователем числа
    @IBAction func checkNumber () {
        
//        подсчет очков за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        
//        проверка окончания игры
        if game.isGameEnded {
//            окно с итогами
            showAlertWith(score: game.score)
            
//            начинаем игру заново
            game.restartGame()
        } else {
//            начинаем новый раунд
            game.startNewRoud()
        }
        
//        обновление данных о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
//    MARK: - обновление View
    
//    обновление текста загаданного числа
     func updateLabelWithSecretNumber(newText: String) {
        secretValueLabel.text = newText
    }
    
//    отображение всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Game over", message: "You earned \(score) points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Start new game", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

