//
//  NormalViewCell.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/09/28.
//

import UIKit

class NormalViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(title: String) {
        label.text = title
    }
}
