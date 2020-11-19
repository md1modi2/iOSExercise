//
//  WSCalls.swift
//  Wipro
//
//  Created by hb on 19/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import UIKit

class WSCalls: NSObject {
    static func callGetFactsWS(onSuccess: ((FactsModel?) -> Void)?, onError: ((Error?) -> Void)?) {
        NetworkService.shared.sendRequestWithUrl(url: AppConstants.baseUrl) {(response: FactsModel?, error) in
            if let response = response, error == nil {
                onSuccess?(response)
            } else {
                onError?(error)
            }
        }
    }
}
