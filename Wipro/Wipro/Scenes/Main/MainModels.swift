//
//  MainModels.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

enum Main {
    enum Facts {
        
        struct Request {
        }
        
        class ViewModel : WSResponse {
            var rows : [Row]?
            var title : String?

            enum CodingKeys: String, CodingKey {
                case rows = "rows"
                case title = "title"
            }
            required init(from decoder: Decoder) throws {
                super.init()
                let values = try decoder.container(keyedBy: CodingKeys.self)
                rows = try values.decodeIfPresent([Row].self, forKey: .rows)
                title = try values.decodeIfPresent(String.self, forKey: .title)
            }
        }
        
        struct Row : Codable {

            let descriptionField : String?
            let imageHref : String?
            let title : String?

            enum CodingKeys: String, CodingKey {
                case descriptionField = "description"
                case imageHref = "imageHref"
                case title = "title"
            }
            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
                title = try values.decodeIfPresent(String.self, forKey: .title)
            }
        }
        
    }
}
