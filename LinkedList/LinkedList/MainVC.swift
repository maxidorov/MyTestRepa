//
//  MainVC.swift
//  LinkedList
//
//  Created by Maxim Sidorov on 30.10.2019.
//  Copyright © 2019 Maxim Sidorov. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = List<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addElem))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(list.size())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")!
        cell.textLabel?.text = String(list.getElem(at: UInt(indexPath.row)) ?? "nil")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.list.remove(at: UInt(indexPath.row))
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Int(list.size() + 1)
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "First"
        } else if row == list.size() {
            return "Last"
        } else {
            return "Index \(row)"
        }
    }
    
    @objc func addElem() {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 50, width: 260, height: 162))
        pickerView.dataSource = self
        pickerView.delegate = self

        let alertView = UIAlertController( title: "Add element at", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertView.view.addSubview(pickerView)
        alertView.addTextField()

        let submitAction = UIAlertAction(title: "Done", style: .default) { [unowned alertView] _ in
            if let elem = alertView.textFields![0].text {
                self.list.add(at: UInt(pickerView.selectedRow(inComponent: 0)), element: elem)
                self.tableView.reloadData()
            }
        }
        
        alertView.addAction(submitAction)
        present(alertView, animated: true, completion: {
            pickerView.frame.size.width = alertView.view.frame.size.width
        })
    }
    
}
