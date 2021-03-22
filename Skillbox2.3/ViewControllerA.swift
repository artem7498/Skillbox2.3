//
//  ViewController.swift
//  Skillbox2.3
//
//  Created by Артём on 10/13/20.
//

import UIKit
import ReactiveKit
import Bond

class ViewControllerA: UIViewController {

//     a) Два текстовых поля. Логин и пароль, под ними лейбл и ниже кнопка «Отправить». В лейбл выводится «некорректная почта», если введённая почта некорректна. Если почта корректна, но пароль меньше шести символов, выводится: «Слишком короткий пароль». В противном случае ничего не выводится. Кнопка «Отправить» активна, если введена корректная почта и пароль не менее шести символов.
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sendButton.isEnabled = false
        
        loginTextField.reactive.text
            .ignoreNils()
            .map{ $0.contains(".") && $0.contains("@") && $0.count > 5 ? "" : "Login must contain 6 or more symbols" }
            .bind(to: warningLabel.reactive.text)
        
        passwordTextField.reactive.text
            .ignoreNils()
            .map {$0.count < 6 && $0.count > 0 ? "password must contain 6 or more symbols" : ""}
            .bind(to: warningLabel.reactive.text)
        
        
        combineLatest(loginTextField.reactive.text, passwordTextField.reactive.text) { email, pass in
            return email!.count > 5 && pass!.count > 6 && email!.contains("@") && email!.contains(".")
        }
        .bind(to: sendButton.reactive.isEnabled)

    }

}

