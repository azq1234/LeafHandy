//
//  CreateNoteVC.swift
//  Leaf handy
//
//  Created by admin on 2022/12/8.
//

import UIKit
typealias sendDiaryClosure=(_ diary:Diary)->Void

class CreateNoteVC: UIViewController{
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var color: UIColorWell!
    @IBOutlet weak var noteTF: UITextView!
    var currentDiary : Diary!
    var diaryClosure:sendDiaryClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentDiary != nil {
            noteTF.text = currentDiary.content
        }
        self.noteTF.textColor = color.selectedColor
        self.saveBtn.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapView))
        view.addGestureRecognizer(tap)
    }
    @objc func tapView() {
        noteTF.resignFirstResponder()
    }
    
    @IBAction func saveHander(_ sender: UIButton) {
        noteTF.resignFirstResponder()
        if noteTF.text.lengthOfBytes(using: .utf8) > 0{
            let diary = Diary(content: noteTF.text)
            if currentDiary != nil{
                let date = Date()
                let dateF = DateFormatter()
                dateF.dateFormat = "yyyy-MM-dd HH:mm"
                diary.name = dateF.string(from: date)
                diary.color = self.color.selectedColor?.toHexString() ?? UIColor(named: "AccentColor")!.toHexString()
                currentDiary = diary
                if diaryClosure != nil{
                    diaryClosure!(currentDiary)
                }
            }else{
                if diaryClosure != nil{
                    diaryClosure!(diary)
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
