//
//  DetailViewModel.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import Foundation

class DetailViewModel: BaseViewModel, BaseViewModelProtocol {
    
    var reloadWith: ((ReloadType) -> Void)?
    let searchResult: SearchResult
    
    enum ReloadType {
        
    }
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
        super.init()
    }
}
