//
//  NSObjectProtocol+Extension.swift
//  carousel
//
//  Created by Sho Yasuda on 2021/09/28.
//

import Foundation
import UIKit

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
