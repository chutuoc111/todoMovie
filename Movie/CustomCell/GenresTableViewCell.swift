//
//  GenresTableViewCell.swift
//  Movie
//
//  Created by TranMinhHieu on 7/28/19.
//  Copyright © 2019 TranMinhHieu. All rights reserved.
//

import UIKit

class GenresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelNameGenres: UILabel!
    @IBOutlet weak var imgViewGenres: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
