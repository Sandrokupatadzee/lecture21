//
//  MainScreen.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import UIKit

class MainScreen: UIViewController {
    
    private var countries: [Country] = []
    private let urlString: String = "https://restcountries.com/v3.1/all"
    private let spaceBetweenSections: CGFloat = 2.0
    
    private let tableView: UITableView = {
        let screenTableView = UITableView()
        screenTableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.identifier)
        return screenTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NetworkService().getData(urlString: urlString) { (result: Result<[Country], Error>) in
            switch result {
            case .success(let success):
                self.countries = success
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    // MARK: functions
    
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
            
        ])
    }
}
//    MARK: extensions
    
    extension MainScreen: UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return self.countries.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as? CountryCell else {
                fatalError("vai, vai, vai")
            }
            let country = countries[indexPath.section]
            cell.configure(with: country)
            cell.backgroundColor = .white
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 18
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
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedCountry = countries[indexPath.section]
            let viewModel = SecondScreenViewModel(country: selectedCountry)
            let nextScreen = SecondScreen(viewModel)
            navigationController?.pushViewController(nextScreen, animated: true)
        }
    }

