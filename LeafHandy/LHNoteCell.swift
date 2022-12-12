//
//  LHNoteCell.swift
//  Leaf handy
//
//  Created by admin on 2022/12/6.
//

import UIKit

class LHNoteCell: UITableViewCell {
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
