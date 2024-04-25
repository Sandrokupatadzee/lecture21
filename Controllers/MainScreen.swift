//
//  MainScreen.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import UIKit

class MainScreen: UIViewController {
    
    private var viewModel = MainScreenViewModel()
    
    private var countries: [Country] = []
    private let urlString: String = "https://restcountries.com/v3.1/all"
    private let spaceBetweenSections: CGFloat = 2.0
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let screenTableView = UITableView()
        screenTableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
        screenTableView.backgroundColor = .clear
        return screenTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        setupUI()
        setupSearchController()
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkService().getData(urlString: urlString) { [weak self] (result: Result<[Country], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.countries = success
                self.viewModel.AllCountries = success
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by capital or alternate spelling"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
// MARK: - TableView and SearchController Extensions

extension MainScreen: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isSearchModeON(searchController: searchController) ? viewModel.filteredCountries.count : viewModel.AllCountries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else {
            fatalError("Could not dequeue reusable cell")
        }
        let country = viewModel.isSearchModeON(searchController: searchController) ? viewModel.filteredCountries[indexPath.section] : viewModel.AllCountries[indexPath.section]
        cell.configure(with: country)
        cell.backgroundColor = .tertiarySystemBackground
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 18
        cell.layer.borderColor = UIColor.secondaryLabel.cgColor
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return spaceBetweenSections
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = viewModel.isSearchModeON(searchController: searchController) ? viewModel.filteredCountries[indexPath.section] : viewModel.AllCountries[indexPath.section]
        let viewModel = SecondScreenViewModel(country: country)
        let nextScreen = SecondScreen(viewModel)
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

extension MainScreen: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearchResults(searchBarText: searchController.searchBar.text)
        tableView.reloadData()
    }
}
