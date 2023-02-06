//
//  MainViewController.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import UIKit

class MainViewController: BaseViewController<MainViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSearchBar()
        self.viewModel.setup()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Search")
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    private func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func reload(_ type: MainViewModel.ReloadType) {
        switch type {
        case .search:
            self.reloadView()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.viewModel.shouldLoadNextPage(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search", for: indexPath) as? SearchResultTableViewCell
        cell?.setup(result: self.viewModel.searchResponse?.results?[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.searchResponse?.results?.count ?? 0
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowData = self.viewModel.searchResponse?.results?[indexPath.row] else {
            return
        }
        
        let viewModel = DetailViewModel(searchResult: rowData)
        let viewController = DetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchChanged(text: searchText)
    }
}
