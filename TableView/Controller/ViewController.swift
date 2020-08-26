//
//  ViewController.swift
//  TableView
//
//  Created by a1111 on 2020/08/26.
//  Copyright © 2020 sym. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let sections = ["A","B"]
    var data1 = ["1","2","3","4","5"]
    var data2 = ["6","7","8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        let editBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 30, height: 30)))
//        editBtn.setTitle("Edit", for: .normal)
//        editBtn.setTitleColor(.red, for: .normal)
        
//        editBtn.addTarget(self, action: #selector(ViewController.edit), for: UIControl.Event.touchUpInside)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(ViewController.edit))
    }
    
    @objc func edit(sender: UIBarButtonItem) {
        if tableView.isEditing {
            sender.title = "Edit"
            tableView.setEditing(false, animated: true)
        } else {
            sender.title = "Done"
            tableView.setEditing(true, animated: true)
        }
    }

}

extension ViewController: UITableViewDataSource {
    // 필수 테이블뷰 메소드 1 (Section 당 row 개수 반환)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return data1.count
        } else {
            return data2.count
        }
    }
    
    // 필수 테이블뷰 메소드 2 (특정 row의 cell 반환)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        if indexPath.section == 0 {
            cell.rowText.text = data1[indexPath.row]
        } else {
            cell.rowText.text = data2[indexPath.row]
        }
        return cell
    }
    
    // Section 의 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // Section 의 title 반환
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // 사용자가 특정 row를 editing 하려고 할 때 반응함. DataSource에게 특정 Cell 의 Editing Style(delete, insert, none) 을 물음 -> 그리고 대응하는 Action을 지정할 수 있음
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                data1.remove(at: indexPath.row)
            } else {
                data2.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .bottom)
        } else if editingStyle == .insert {
            if indexPath.section == 0 {
                data1.insert("NEW", at: indexPath.row)
            } else {
                data2.insert("NEW", at: indexPath.row)
            }
            tableView.insertRows(at: [indexPath], with: .bottom)
        }
    }
    
    // row 옮기기
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var text = ""
        if sourceIndexPath.section == 0 {
            text = data1.remove(at: sourceIndexPath.row)
        } else {
            text = data2.remove(at: sourceIndexPath.row)
        }
        
        if destinationIndexPath.section == 0 {
            data1.insert(text, at: destinationIndexPath.row)
        } else {
            data2.insert(text, at: destinationIndexPath.row)
        }
        print(data1, data2)
    }
    
}

extension ViewController: UITableViewDelegate {
    // 특정 row 선택 시 반응
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("data1:", data1[indexPath.row])
        } else {
            print("data2:", data2[indexPath.row])
        }
    }
    // 각 row 에 대한 editingStyle 을 설정 (swipe 하거나 edit button (setediting이 true가 되면) 반응함)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .delete
        } else {
            return .insert
        }
        
    }
}
