//
//  ViewControllerC.swift
//  Skillbox2.3
//
//  Created by Артём on 10/15/20.
//

import UIKit
import Bond
import ReactiveKit

class ViewControllerCF: UIViewController {
    
    //  c) UITableView с выводом 20 разных имён людей и две кнопки. Одна кнопка добавляет новое случайное имя в начало списка, вторая — удаляет последнее имя. Список реактивно связан с UITableView.
    
//      f) Для задачи «c» добавьте поисковую строку. При вводе текста в поисковой строке, если текст не изменялся в течение двух секунд, выполните фильтрацию имён по введённой поисковой строке (с помощью оператора throttle). Такой подход применяется в реальных приложениях при поиске, который отправляет поисковый запрос на сервер, — чтобы не перегружать сервер и поисковая строка отправлялась на сервер, только когда пользователь закончит ввод (или сделает паузу во вводе).
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var names = MutableObservableArray(["John", "David", "Carlos", "Emma", "Anna", "Josh", "Alex", "Marina", "Diana", "Donald", "Valentin", "Shawn", "Aaron", "Jojo", "Arthur", "Kiki", "Mendoza", "Nancy", "Chloe", "Wendy"])
    
    var otherNames = ["John", "David", "Carlos", "Emma", "Anna", "Josh", "Alex", "Marina", "Diana", "Donald", "Valentin", "Shawn", "Aaron", "Jojo", "Arthur", "Kiki", "Mendoza", "Nancy", "Chloe", "Wendy"]
    
    var filtredNames = MutableObservableArray<String>([])
    var savedNames = MutableObservableArray<String>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        loadNames()

// Задание F:
        searchTextField.reactive.text
            .ignoreNils()
            .filter{$0.count > 3}
            .throttle(for: 2.0)
            .observeNext(with: { [self] searchTextField in
                print(searchTextField)
                self.filtredNames.removeAll()
                self.savedNames.replaceElements(with: self.savedNames.array).bind(to: self.names)
                for name in self.names.array{
                        if name.hasPrefix(searchTextField){
                            self.filtredNames.append(name)
                        }

//                    self.filtredNames.replaceElements(with: self.filtredNames.array).bind(to: self.names)
//                    tableView.reloadData()
                    loadNames()
                    
                    print(self.filtredNames.array)
                    print("df\(self.names.array)")
                }
                self.filtredNames.replaceElements(with: self.filtredNames.array).bind(to: self.names)
                
//                loadNames()
                
            }).dispose(in: bag)
    }
    
    
    
    func loadNames(){
    names.bind(to: tableView) { (dataSource, indexPath, tableView) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCellC
        cell.nameLabel.text = dataSource[indexPath.row]
        return cell
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
//        let myItem = names.getRandomItem()
        print("hh")
//        var index = Int(arc4random() % UInt32(names.count))
//        var shot = names[Int(index)]
        names.insert(otherNames.randomElement()!, at: 0)
    }
    
    
    @IBAction func deleteButton(_ sender: Any) {
        if names.isEmpty{
            print("array is empty")
        } else { names.removeLast() }
    }

}


extension ViewControllerCF: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let count = textField.text?.count, count == 0 {
            names.replaceElements(with: names.array).bind(to: savedNames)
            print("namess \(names.array)")
            print("savedd \(savedNames.array)")
        } else {
            savedNames.replaceElements(with: savedNames.array).bind(to: names)
            loadNames()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let count = textField.text?.count, count < 4 {
            names = savedNames
            loadNames()
        } else {
            loadNames()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let count = textField.text?.count, count != 0 {
            return false
        } else {
            savedNames.replaceElements(with: savedNames.array).bind(to: names)
            loadNames()
        }
        return true
    }
    
    
}
