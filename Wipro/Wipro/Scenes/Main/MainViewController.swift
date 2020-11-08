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
    
    // MARK: Setup CleanSwift Module
    
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
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = UIColor.gray
        refreshControl.addTarget(self, action: #selector(doRefresh), for: .valueChanged)
        return refreshControl
    }()
    var arrFacts: [Main.Facts.Row] = [Main.Facts.Row]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doGetFacts()
    }
    
    /// This method is use to setup the initial configuration for viewcontroller and tableview
    private func initialSetup() {
        tblView.register(FactCell.cellNib, forCellReuseIdentifier: FactCell.cellIdentifier)
        tblView.tableFooterView = UIView()
        tblView.dataSource = self
        tblView.delegate = self
        addPullToRefresh()
    }
    
    /// This method will add refresh control to tableview
    private func addPullToRefresh() {
        if #available(iOS 10.0, *) {
            if tblView.refreshControl == nil {
                tblView.refreshControl = refreshControl
            }
        } else {
            // Fallback on earlier versions
            tblView.addSubview(refreshControl)
        }
    }
    
    /// This method will use to stop animating and hide the refresh control
    private func endRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: IBActions
    
    /// This action will perform the pull to refresh action and call the API
    @IBAction private func doRefresh() {
        doGetFacts()
    }
    
    // MARK: API Calling
    
    /// This method will call the API through interactor if network is available
    private func doGetFacts() {
        if NetworkState().isInternetAvailable == true {
            self.navigationItem.title = "Loading..."
            interactor?.getFacts(request: Main.Facts.Request())
        } else {
            self.navigationItem.title = "Pull To Refresh"
            AppUtility.showToastMessage(MessageConstants.NoInternet, isSuccess: false)
            endRefreshing()
        }
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FactCell.cellIdentifier) as? FactCell else {
            return UITableViewCell()
        }
        cell.setContent(model: arrFacts[indexPath.row])
        return cell
    }
}

extension MainViewController : MainDisplayLogic {
    func displayFacts(viewModel: Main.Facts.ViewModel) {
        self.navigationItem.title = viewModel.title
        if let arrayRows = viewModel.rows {
            self.arrFacts = arrayRows
        }
        tblView.reloadData()
        endRefreshing()
    }
    
    func displayError(error: Error?) {
        endRefreshing()
        self.navigationItem.title = "Pull To Refresh"
        AppUtility.showToastMessage(error?.localizedDescription, isSuccess: false)
    }
}
