//
//  ViewController.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import UIKit

final class SectionsTableViewController: UITableViewController, ViewControllerProtocol {
    var _viewModel: ViewModelProtocol
    var viewModel: SectionsViewModelProtocol {
        get {
            guard let viewModel = _viewModel as? SectionsViewModel else {
                fatalError("Programming error")
            }
            return viewModel
        }
        set {
            _viewModel = newValue
        }
    }
    
    required init(viewModel: ViewModelProtocol) {
        self._viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataRetrieved = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
        
        refreshControl = UIRefreshControl(frame: .zero, primaryAction: .init(handler: { [weak self] _ in
            self?.viewModel.retrieveData(ignoreCache: true)
        }))
        
        viewModel.retrieveData(ignoreCache: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = viewModel.title
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.set(title: viewModel.model.title, description: viewModel.model.description)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.model.description
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.links.viaplaySections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel.model.links.viaplaySections[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = viewModel.url(atIndex: indexPath.row) else {
            return
        }
        viewModel.selectSection(url: url, title: viewModel.title(atIndex: indexPath.row))
    }
}

