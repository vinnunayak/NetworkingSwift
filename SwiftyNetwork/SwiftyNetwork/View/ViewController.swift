//
//  ViewController.swift
//  SwiftyNetwork
//
//  Created by Vinod Nayak Banavath on 19/07/23.
//

import UIKit

class MainViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.delegate = viewModel
        tableview.dataSource = viewModel
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = 60
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "AlbumCell")
        return tableview
    }()
    
    
    let viewModel = AlbumsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        //Fetch Data
        viewModel.fetchAlbumsData { [weak self] status in
            if status {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func initTableView(){
        self.navigationItem.title = "SwiftyNetwork + MVVM"
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

