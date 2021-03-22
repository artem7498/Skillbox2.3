//
//  ViewController6.swift
//  Skillbox2.3
//
//  Created by Артём on 10/16/20.
//

import UIKit
import ReactiveKit
import Bond

class ViewController6: UIViewController {

    let myButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        6. Напишите несколько примеров того, как может образоваться утечка памяти при использовании Rx.
        
        
//        Необходимо для того, чтобы оперативная память не перегружалась. И при отработке ненужные параметры самоутилизировались.
        
        
        myButton.reactive.tap.observeNext {
            self.sayHello()
        }.dispose(in: reactive.bag)
        
        
        myButton.reactive.tap.observeNext{ [weak self] in
            self?.sayHello()
        }
        
        
        
//        NotificationCenter.default.reactive.notification(name: <#T##NSNotification.Name#>)
//          .observeNext { notification in
//            print("Got \(notification)")
//          }
//            .dispose(in: reactive.bag)
//
//
//        repositories.bind(to: collectionView) { array, indexPath, collectionView in
//          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RepositoryCell
//          let repository = array[indexPath.item]
//
//          repository.name
//            .bind(to: cell.nameLabel)
//            .dispose(in: cell.onReuseBag)
//
//          repository.photo
//            .bind(to: cell.avatarImageView)
//            .dispose(in: cell.onReuseBag)
//
//          return cell
//        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func sayHello(){
        print("something")
    }
    

}
