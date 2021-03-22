//
//  ViewControllerE.swift
//  Skillbox2.3
//
//  Created by Артём on 10/15/20.
//

import UIKit
import ReactiveKit
import Bond


//Две кнопки и лейбл. Когда на каждую кнопку нажали хотя бы один раз, в лейбл выводится: «Ракета запущена».

class ViewControllerE: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
//    let name = Property("ракета запущена")
    
    var isFirstButtonEnabled = Property(false)
    var isSecondButtonEnabled = Property(false)
    
    var activated = Property(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        name
//            .map{self.isFirstButtonEnabled.value == true && self.isSecondButtonEnabled.value == true ? "\($0)" : ""}
//            .bind(to: statusLabel)
            
        
        isFirstButtonEnabled.combineLatest(with: isSecondButtonEnabled)
            .map{$0 == true && $1 == true}
            .bind(to: activated)
        
        activated
            .map{$0 == true ? "ракета запущена" : "ракета на стоянке"}
            .bind(to: statusLabel)
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func firstBttn(_ sender: Any) {
        isFirstButtonEnabled.value = !isFirstButtonEnabled.value
        if isFirstButtonEnabled.value == false{
            firstButton.backgroundColor = .red
        }else{
            firstButton.backgroundColor = .green}
        print(isFirstButtonEnabled.value)
    }
    @IBAction func scndBttn(_ sender: Any) {
        isSecondButtonEnabled.value = !isSecondButtonEnabled.value
        if isSecondButtonEnabled.value == false{
            secondButton.backgroundColor = .red
        }else{secondButton.backgroundColor = .green}
        print(isFirstButtonEnabled.value)
        print(isSecondButtonEnabled.value)
    }
    
    
}
