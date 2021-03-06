//
//  MainInteractor.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func getFacts(request: Main.Facts.Request)
}

class MainInteractor: MainBusinessLogic {
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    
    // MARK: Presenter Business Logic
    
    /// This method will call the API through Worker Class and pass the response to presenter to present data or error
    /// - Parameter request: Facts API request - If there is any parameter then it will be pass through this request model
    func getFacts(request: Main.Facts.Request) {
        worker = MainWorker()
        worker?.doGetFactsAPI(request: request, completionHandler: { [weak self] (response, error) in
            guard let weakSelf = self else {return}
            if let obj = response {
                weakSelf.presenter?.presentFacts(response: obj)
            } else {
                weakSelf.presenter?.presentError(error: error)
            }
        })
    }
}
