//
//  BaseViewModel.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import Foundation

protocol BaseViewModelProtocol: BaseViewModel {
    associatedtype ReloadType
    var reloadWith: ((ReloadType) -> Void)? { get set }
}

class BaseViewModel { }

