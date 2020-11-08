//
//  FactCell.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import UIKit
import Kingfisher

class FactCell: UITableViewCell {

    static let cellIdentifier = "FactCell"
    static let cellNib = UINib.init(nibName: "FactCell", bundle: Bundle.main)
    
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        imgView.layer.cornerRadius = 3.0
        imgView.kf.indicatorType = .activity
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// This function is used to set the Cell UI with response model
    /// - Parameter model: Fact Model
    func setContent(model: Main.Facts.Row) {
        if let strUrl = model.imageHref, let imgUrl = URL(string: strUrl) {
            imgView.kf.setImage(with: imgUrl)
        }
        lblTitle.text = model.title?.trimmingCharacters(in: CharacterSet.whitespaces) ?? "N/A"
        lblDesc.text = model.descriptionField?.trimmingCharacters(in: CharacterSet.whitespaces) ?? "Information N/A"
    }
    
}
