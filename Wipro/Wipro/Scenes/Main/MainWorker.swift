//
//  MainWorker.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

class MainWorker {
    
    /// This method will call the network service to fetch the data and convert response to relative generic model
    /// - Parameter request: API Request Model -  It will contains the request parameter values to generate http body through Router Class - CommonRouter
    /// - Parameter completionHandler: Closure method will get response from Network service and pass back to interactor
    func doGetFactsAPI(request: Main.Facts.Request, completionHandler: @escaping (Main.Facts.ViewModel?, Error?) -> Void) {
        let router = CommonRouter.getFacts
        NetworkService.dataRequest(with: router) { (response, error) in
            completionHandler(response, error)
        }
    }
}
