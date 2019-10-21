//
//  CustomCollectionViewCell.swift
//  Webant_Junior
//
//  Created by Лекс Лютер on 18/10/2019.
//  Copyright © 2019 Лекс Лютер. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        designFor(image: image)
    }
}
