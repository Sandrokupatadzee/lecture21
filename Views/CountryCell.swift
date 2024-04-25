//
//  CountryCell.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import UIKit

class CountryCell: UITableViewCell {

    static let identifier = "CountryCell"
    private var country: Country?

    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let contryName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let actoinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.image = UIImage(systemName: "greaterthan")
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with country: Country) {
        self.country = country
        contryName.attributedText = attributedText(for: country.region)

        guard let imageUrl = URL(string: country.flags.png) else {
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.countryFlag.image = image
            }
        }.resume()
    }
    
//    MARK: - Functions
    
    private func setupUI() {
        addSubview(countryFlag)
        addSubview(contryName)
        addSubview(actoinImage)
        
        countryFlag.translatesAutoresizingMaskIntoConstraints = false
        contryName.translatesAutoresizingMaskIntoConstraints = false
        actoinImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            countryFlag.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            countryFlag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countryFlag.heightAnchor.constraint(equalToConstant: 60),
            countryFlag.widthAnchor.constraint(equalToConstant: 100),
        
            contryName.centerYAnchor.constraint(equalTo: centerYAnchor),
            contryName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),

            actoinImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            actoinImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            actoinImage.heightAnchor.constraint(equalToConstant: 20),
            actoinImage.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func attributedText(for text: String) -> NSAttributedString {
            let strokeTextAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18)
            ]
            return NSAttributedString(string: text, attributes: strokeTextAttributes)
        }
}
