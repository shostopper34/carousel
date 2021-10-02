//
//  CarouselViewCell.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/09/28.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
    }

    func set(title: String) {
        numberLabel.text = title
    }
}
