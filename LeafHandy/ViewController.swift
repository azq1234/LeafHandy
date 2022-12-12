//
//  ViewController.swift
//  LeafHandy
//
//  Created by admin on 2022/12/10.
//

import UIKit

import BTNavigationDropdownMenu

class ViewController: UIViewController {
    var dataArray = Array<Any>()
    var menuView: BTNavigationDropdownMenu!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let items = [NSLocalizedString("Create Note", comment: "")]
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(2), items: items)
        menuView.setSelected(index: 0)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = .white
        menuView.cellSelectionColor =  UIColor(named: "backline1")
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellSeparatorColor = UIColor(named: "seperator")
        menuView.cellTextLabelColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.selectedCellTextLabelColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.menuTitleColor =  self.navigationController?.navigationBar.barTintColor
        menuView.arrowTintColor =  self.navigationController?.navigationBar.barTintColor
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("Did select item at index: \(indexPath)")
            if indexPath == 0 {
                let inputCon = CreateNoteVC(nibName: "CreateNoteVC", bundle: nil)
                inputCon.diaryClosure = {(diary: Diary) -> Swift.Void in
                    self.dataArray.append(diary)
                    self.tableView?.reloadData()
                    let model =  diary.convertToDictionary();
                    var data = UserDefaults.standard.object(forKey: "lf_node")
                    if data == nil{
                        UserDefaults.standard.setValue([model], forKey: "lf_node")
                    }else{
                        if var data2:Array = data as? Array<Any> {
                            data2.append(model)
//                            UserDefaults.standard.set(data2, forKey: )
                            UserDefaults.standard.set(data2, forKey: "lf_node")
                        }
                    }
                }
                self.present(inputCon, animated: true, completion: nil)
            }
        }
        self.navigationItem.titleView = menuView
        self.tableView.register(UINib(nibName: "LHNoteCell", bundle: nibBundle), forCellReuseIdentifier: "LHNoteCell")
        let data = UserDefaults.standard.object(forKey: "lf_node")
        if data == nil {
            self.dataArray = []
        }else{
            for idc in (data as? [Any])! {
                let model = Diary(dic: idc as! Dictionary<String, Any>)
                self.dataArray.append(model)
            }
        }
        self.tableView.reloadData()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: "LHNoteCell", for: indexPath) as! LHNoteCell
        let item = dataArray[indexPath.row] as? Diary
        cell.note?.text = item?.content
        cell.note.textColor = UIColor.init(hex: item?.color ?? UIColor(named: "AccentColor")!.toHexString())
        cell.time.textColor = UIColor.init(hex: item?.color ?? UIColor(named: "AccentColor")!.toHexString())
        cell.time?.text = item?.name
        return cell;
    }
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inputCon = CreateNoteVC(nibName: "CreateNoteVC", bundle: nil)
        let item = dataArray[indexPath.row] as? Diary
        inputCon.currentDiary = item
        inputCon.diaryClosure = {(diary: Diary) -> Swift.Void in
            for (index,individual) in self.dataArray.enumerated() {
                let selectedDiary = individual as! Diary
                if selectedDiary.creatTimestamp == item?.creatTimestamp  {
                    self.dataArray[index] = diary
                }
            }
            self.tableView?.reloadData()
        }
        self.present(inputCon, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            dataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let data = UserDefaults.standard.object(forKey: "lf_node")
            if data == nil{
            }else{
                if var data2:Array = data as? Array<Any> {
                    data2.remove(at: indexPath.row)
                    UserDefaults.standard.set(data2, forKey: "lf_node")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }

}
