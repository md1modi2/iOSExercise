//
//  FactsModel.swift
//  Wipro
//
//  Created by hb on 18/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import UIKit

class FactsModel : WSResponse {

    var rows : [FactRowModel]?
    var title : String?

    enum CodingKeys: String, CodingKey {
        case rows = "rows"
        case title = "title"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rows = try values.decodeIfPresent([FactRowModel].self, forKey: .rows)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
