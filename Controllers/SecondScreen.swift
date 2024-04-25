//
//  SecondScreen.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import UIKit

class SecondScreen: UIViewController {
    
    private var viewModel: SecondScreenViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let countryFlagContainerView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 15
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowRadius = 2.0
        uiView.layer.shadowOpacity = 0.5
        uiView.layer.shadowOffset = CGSize(width: 0, height: 5)
        uiView.layer.masksToBounds = false
        return uiView
    }()
    
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let flagTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "About the flag:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let flagDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 10
        return label
    }()
    
    private let horizontalLine: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return line
    }()
    
    private let infoTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Basic informaion:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - Stackview and Buttons

    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelsStackView, contentStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let horizontalLine2: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return line
    }()
    
    private let linkTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Useful links:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var googleMapsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "googleMap"), for: .normal)
        button.addAction(UIAction(handler: {_ in
            self.viewModel.googleMapButtonTapped()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var openStreetMapsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "streetMap"), for: .normal)
        button.addAction(UIAction(handler: {_ in
            self.viewModel.streetMapButtonTapped()
        }), for: .touchUpInside)
        return button
    }()
    
    
    //    MARK: - initialisation
    
    init(_ viewModel: SecondScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        setupScrollView()
        configure()
    }
    
    private func setupScrollView() {
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(countryFlagContainerView)
        self.countryFlagContainerView.addSubview(countryFlag)
        self.contentView.addSubview(flagTitle)
        self.contentView.addSubview(flagDescription)
        self.contentView.addSubview(horizontalLine)
        self.contentView.addSubview(infoTitle)
        self.contentView.addSubview(horizontalStackView)
        self.contentView.addSubview(horizontalLine2)
        self.contentView.addSubview(linkTitle)
        self.contentView.addSubview(googleMapsButton)
        self.contentView.addSubview(openStreetMapsButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        countryFlagContainerView.translatesAutoresizingMaskIntoConstraints = false
        countryFlag.translatesAutoresizingMaskIntoConstraints = false
        flagTitle.translatesAutoresizingMaskIntoConstraints = false
        flagDescription.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        infoTitle.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine2.translatesAutoresizingMaskIntoConstraints = false
        linkTitle.translatesAutoresizingMaskIntoConstraints = false
        googleMapsButton.translatesAutoresizingMaskIntoConstraints = false
        openStreetMapsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            countryFlagContainerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            countryFlagContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            countryFlagContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            countryFlagContainerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            countryFlagContainerView.heightAnchor.constraint(equalToConstant: 200),
            
            countryFlag.topAnchor.constraint(equalTo: self.countryFlagContainerView.topAnchor),
            countryFlag.leadingAnchor.constraint(equalTo: self.countryFlagContainerView.leadingAnchor),
            countryFlag.trailingAnchor.constraint(equalTo: self.countryFlagContainerView.trailingAnchor),
            countryFlag.bottomAnchor.constraint(equalTo: self.countryFlagContainerView.bottomAnchor),
            
            flagTitle.topAnchor.constraint(equalTo: countryFlagContainerView.bottomAnchor, constant: 15),
            flagTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            flagTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            flagDescription.topAnchor.constraint(equalTo: flagTitle.bottomAnchor, constant: 15),
            flagDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            flagDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            horizontalLine.topAnchor.constraint(equalTo: flagDescription.bottomAnchor, constant: 15),
            horizontalLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            horizontalLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            infoTitle.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 15),
            infoTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            infoTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            horizontalStackView.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 15),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            horizontalLine2.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 15),
            horizontalLine2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            horizontalLine2.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            linkTitle.topAnchor.constraint(equalTo: horizontalLine2.bottomAnchor, constant: 15),
            linkTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            linkTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            googleMapsButton.topAnchor.constraint(equalTo: linkTitle.bottomAnchor, constant: 20),
            openStreetMapsButton.topAnchor.constraint(equalTo: linkTitle.bottomAnchor, constant: 20),
            
            googleMapsButton.widthAnchor.constraint(equalToConstant: 60),
            googleMapsButton.heightAnchor.constraint(equalToConstant: 60),
            openStreetMapsButton.widthAnchor.constraint(equalTo: googleMapsButton.widthAnchor),
            openStreetMapsButton.heightAnchor.constraint(equalTo: googleMapsButton.heightAnchor),
            
            googleMapsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 67),
            openStreetMapsButton.leadingAnchor.constraint(equalTo: googleMapsButton.trailingAnchor, constant: 115),
            
            googleMapsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            openStreetMapsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        
    }
    
    public func configure() {
        flagDescription.text = viewModel.flagDescription
        configureLabels(labels: viewModel.labels, content: viewModel.content)
        
        guard let imageUrl = viewModel.flagImageUrl else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else
            {return}
            DispatchQueue.main.async {
                self.countryFlag.image = image
            }
        }.resume()
    }
    
    private func configureLabels(labels: [UILabel], content: [UILabel]) {
        guard labels.count == content.count else { return }
        for element in 0..<labels.count {
            labelsStackView.addArrangedSubview(labels[element])
            contentStackView.addArrangedSubview(content[element])
        }
    }
    
}
