//
//  MainViewModel.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import Foundation

class MainViewModel: BaseViewModel, BaseViewModelProtocol {
    
    var searchResponse: SearchResponse?
    private let networkClient: NetworkClient
    private var loading: Bool = false
    private var currentSearch: String = ""
    
    var reloadWith: ((ReloadType) -> Void)?
    
    enum ReloadType {
        case search
    }
    
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
        super.init()
    }
    
    // MARK: - Public methods
    
    func setup() {
        self.search()
    }
    
    func searchChanged(text: String) {
        self.currentSearch = text
        self.search()
    }
    
    func shouldLoadNextPage(index: Int) {
        guard let count = self.searchResponse?.results?.count,
              index + 2 > count,
              !self.loading,
              !(self.searchResponse?.meta?.results?.total == count) else {
            return
        }
        
        self.search(skip: count)
    }
    
    // MARK: - Private methods
    
    private func search(skip: Int? = nil) {
        self.loading = true
        self.networkClient.fetchSearchMedication(search: self.currentSearch, skip: skip) { [weak self] result in
            self?.loading = false
            switch result {
            case .success(let response):
                self?.searchResponse = response
                self?.reloadWith?(.search)
            case .failure(let error):
                print(error)
            }
        }
    }
}
