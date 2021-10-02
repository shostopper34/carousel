//
//  TopViewCell.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/10/02.
//

import UIKit

class TopViewCell: UICollectionViewCell {

    @IBOutlet weak var topLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(title: String) {
        topLabel.text = title
    }
}
