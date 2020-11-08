//
//  MainViewController.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: class {
    func displayFacts(viewModel: Main.Facts.ViewModel)
    func displayError(error: Error?)
}

class MainViewController: UIViewController {
    var interactor: MainBusinessLogic?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            print("Segue Identifier : ", scene)
        }
    }
    
    // MARK: View lifecycle
    
    @IBOutlet private weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        tblView.tableFooterView = UIView()
    }
}

extension MainViewController : MainDisplayLogic {
    func displayFacts(viewModel: Main.Facts.ViewModel) {
        
    }
    func displayError(error: Error?) {
        
    }
}
