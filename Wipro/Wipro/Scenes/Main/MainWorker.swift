//
//  MainWorker.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

class MainWorker {
    func doSomeWork() {
    }
    func doGetFactsAPI(request: Main.Facts.Request, completionHandler: @escaping (Main.Facts.ViewModel?, Error?) -> Void) {
        let router = CommonRouter.getFacts
        NetworkService.dataRequest(with: router) { (response, error) in
            completionHandler(response, error)
        }
    }
}
