//
//  TaskCell.swift
//  TODO
//
//  Created by Wojtek Rempiński on 26/05/2022.
//

import UIKit
import SwipeCellKit

class TaskCell: SwipeTableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var taskImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
