//
//  MainPresenter.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func presentFacts(response: Main.Facts.ViewModel)
    func presentError(error: Error?)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    // MARK: Display Response
    func presentFacts(response: Main.Facts.ViewModel) {
        viewController?.displayFacts(viewModel: response)
    }
    func presentError(error: Error?) {
        viewController?.displayError(error: error)
    }
}
