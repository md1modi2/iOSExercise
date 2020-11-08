//
//  CommonRouter.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import Foundation
import Alamofire

enum CommonRouter: RouterProtocol {
    
    var baseUrlString: String {
        return AppConstants.baseUrl
    }
    
    case getFacts
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getFacts:
            return "facts.json"
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.httpBody
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var deviceInfo: [String : Any]? {
        return nil
    }
}
