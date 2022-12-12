//
//  Diary.swift
//  Leaf handy
//
//  Created by admin on 2022/12/8.
//

import UIKit

class Diary: NSObject {
    var name : String?
    var creatTimestamp : String?
    var content : String?
    var color : String?
    init(name :String,content:String,creatTimestamp:String,color:String){
        self.name = name
        self.content = content
        self.creatTimestamp = creatTimestamp
        self.color = color
    }
    init(content:String){
        let date = Date()
        let timestamp = date.timeIntervalSince1970
        self.content = content
        self.creatTimestamp = String(timestamp)
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.name = dateF.string(from: date)
    }
    init(dic:Dictionary<String, Any>){
        self.name = dic["name"] as! String?
        self.content = dic["content"] as! String?
        self.creatTimestamp = dic["creatTimestamp"] as! String?
        self.color =  dic["color"] as! String?
    }
    func convertToDictionary()->Dictionary<String, Any>{
        var dictionary = Dictionary<String, Any>()
        dictionary.updateValue(self.name ?? "", forKey: "name")
        dictionary.updateValue(self.creatTimestamp ?? "", forKey: "creatTimestamp")
        dictionary.updateValue(self.content ?? "", forKey: "content")
        dictionary.updateValue(self.color ?? "", forKey: "color")
        return dictionary
    }
}
