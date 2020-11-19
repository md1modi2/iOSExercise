//
//  MainViewController.swift
//  Wipro
//
//  Created by hb on 08/11/20.
//  Copyright (c) 2020 Hiddenbrains. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: View lifecycle
    
    let tblView = UITableView()
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = UIColor.gray
        refreshControl.addTarget(self, action: #selector(doRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    var arrFacts: [FactRowModel] = [FactRowModel]()
    
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
        
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(FactCell.self, forCellReuseIdentifier: FactCell.cellIdentifier)
        tblView.tableFooterView = UIView()
        tblView.dataSource = self
        tblView.delegate = self
        tblView.estimatedRowHeight = 66
        addPullToRefresh()
        view.addSubview(tblView)
        
        // setting constraints for the TableView
        NSLayoutConstraint.activate([
            tblView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tblView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tblView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tblView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
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
    @IBAction func doRefresh() {
        doGetFacts()
    }
    
    // MARK: API Calling
    
    /// This method will call the API through interactor if network is available
    private func doGetFacts() {
        if NetworkState().isInternetAvailable == true {
            self.navigationItem.title = "Loading..."
            callGetFactsWS()
        } else {
            AppUtility.showToastMessage(MessageConstants.NoInternet, isSuccess: false)
            endRefreshing()
            configureEmptyDataSet()
        }
    }
    
    func callGetFactsWS() {
        WSCalls.callGetFactsWS(onSuccess: { [weak self] (response) in
            guard let weakSelf = self else {return}
            if let arrayRows = response?.rows {
                weakSelf.arrFacts = arrayRows
            }
            DispatchQueue.main.async {
                weakSelf.navigationItem.title = response?.title
                weakSelf.tblView.reloadData()
                weakSelf.endRefreshing()
                weakSelf.configureEmptyDataSet()
            }
        }, onError: { (error) in
            AppUtility.showToastMessage(error?.localizedDescription, isSuccess: false)
        })
    }
    
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FactCell.cellIdentifier) as? FactCell else {
            return UITableViewCell()
        }
        cell.setContent(model: arrFacts[indexPath.row])
        return cell
    }
}
