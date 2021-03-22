//
//  ViewControllerBViewController.swift
//  Skillbox2.3
//
//  Created by Артём on 10/14/20.
//

import UIKit
import Bond
import ReactiveKit

class ViewControllerB: UIViewController {
    
    
//      b) Текстовое поле для ввода поисковой строки. Реализуйте симуляцию «отложенного» серверного запроса при вводе текста: если не было внесено никаких изменений в текстовое поле в течение 0,5 секунд, то в консоль должно выводиться: «Отправка запроса для <введенный текст в текстовое поле>».

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.reactive.text
            .ignoreNils()
            .filter {$0.count > 0}
            .map{"идет поиск: \($0)"}
            .debounce(for: 0.5)
            .observeNext(with: { searchTextField in
                print(searchTextField)
            })
    }
}
