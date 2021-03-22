//
//  ViewControllerD.swift
//  Skillbox2.3
//
//  Created by Артём on 10/15/20.
//

import UIKit
import ReactiveKit
import Bond

class ViewControllerD: UIViewController {

//    Лейбл и кнопку. В лейбле выводится значение counter (по умолчанию 0), при нажатии counter увеличивается на 1
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusOneButton: UIButton!
    
    var counter = Property(0) /*или Observable??*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        plusOneButton.reactive.tap.with(latestFrom: score)
//            .compactMap{$1}
//            .map { "\($0)" }
//            .bind(to: counterLabel)
        
        
        counter.map{"\($0)"}
            .bind(to: counterLabel)

    }
    
    @IBAction func countButton(_ sender: Any) {
        counter.value += 1
    }
    

}
