//
//  MainScreenViewModel.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import Foundation
import UIKit

class MainScreenViewModel {
    
    var onCountryUpdated: (() -> Void) = {}
//    var onErrorMessage: (() -> Void) = {}

    var AllCountries: [Country] = [] {
        didSet {
            onCountryUpdated()
        }
    }

    var filteredCountries: [Country] = [] {
        didSet {
            onCountryUpdated()
        }
    }

    init() {}
}

// MARK: - Extensions

extension MainScreenViewModel {
    
    public func isSearchModeON(searchController: UISearchController?) -> Bool {
        guard let searchController = searchController else {
            return false
        }

        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }

    public func updateSearchResults(searchBarText: String?) {
        filteredCountries = AllCountries
        
        if let searchText = searchBarText?.lowercased(), !searchText.isEmpty {
            filteredCountries = filteredCountries.filter { country in
                if country.capital?.first(where: { $0.lowercased().contains(searchText) }) != nil {
                    return true
                }
                if country.altSpellings.first(where: { $0.lowercased().contains(searchText) }) != nil {
                    return true
                }
                return false
            }
        }
    }
}
