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
    
    let lblTitle = UILabel()
    let lblDesc = UILabel()
    let imgView = UIImageView()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // setting attributes for labels and imageview.
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.setContentCompressionResistancePriority(.required, for: .vertical)
        lblTitle.font = UIFont.boldSystemFont(ofSize: 17.0)
        lblTitle.numberOfLines = 1
        
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        lblDesc.setContentCompressionResistancePriority(.required, for: .vertical)
        lblDesc.font = UIFont.systemFont(ofSize: 15.0)
        lblDesc.numberOfLines = 0
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        
        stackView.addArrangedSubview(lblTitle)
        stackView.addArrangedSubview(lblDesc)

        // Adding the labels and imageview to contentview
        contentView.addSubview(imgView)
        contentView.addSubview(stackView)
        
        // setting constraints
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imgView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            imgView.heightAnchor.constraint(equalToConstant: AppConstants.isIPad ? 80.0 : 50.0),
            imgView.widthAnchor.constraint(equalToConstant: AppConstants.isIPad ? 80.0 : 50.0),
            
            stackView.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This function is used to set the Cell UI with response model
    /// - Parameter model: Fact Model
    func setContent(model: FactRowModel) {
        if let strUrl = model.imageHref, let imgUrl = URL(string: strUrl) {
            imgView.kf.setImage(with: imgUrl)
        }
        lblTitle.text = model.title?.trimmingCharacters(in: CharacterSet.whitespaces) ?? "N/A"
        lblDesc.text = model.descriptionField?.trimmingCharacters(in: CharacterSet.whitespaces) ?? "Information N/A"
    }
}
