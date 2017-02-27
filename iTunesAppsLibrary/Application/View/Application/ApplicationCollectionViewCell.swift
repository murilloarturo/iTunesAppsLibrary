//
//  ApplicationCollectionViewCell.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/26/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import UIKit

class ApplicationCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    @IBOutlet weak var applicationImageView: UIImageView!
    @IBOutlet weak var applicationTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
