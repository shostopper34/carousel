//
//  CarouselRightButtonView.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/09/28.
//

import UIKit
import RxSwift
import RxCocoa

class CarouselRightButtonView: UICollectionReusableView {

    @IBOutlet weak var nextButton: UIButton!
    
    var tapNext: Observable<Void> {
        return nextButton.rx.tap.asObservable()
    }
    
    private(set) var disposeBag: DisposeBag! = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
