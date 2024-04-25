//
//  SecondScreenViewModel.swift
//  lecture21
//
//  Created by MacBook Pro on 24.04.24.
//

import UIKit

class SecondScreenViewModel {
    
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var flagDescription: String {
        return country.flags.alt ?? ""
    }
    
    var flagImageUrl: URL? {
        return URL(string: country.flags.png)
    }
    
    var labels: [UILabel] {
        return [
            makeLabel(text: "Capital:"),
            makeLabel(text: "Region:"),
            makeLabel(text: "Subregion:"),
            makeLabel(text: "Continents:"),
            makeLabel(text: "Landlocked:"),
            makeLabel(text: "Area:"),
            makeLabel(text: "Borders:"),
            makeLabel(text: "Flag:"),
            makeLabel(text: "AltSpellings:"),
            makeLabel(text: "Population:"),
            makeLabel(text: "Timezones:"),
            makeLabel(text: "StartOfWeek:"),
            makeLabel(text: "Fifa:")
        ]
    }
    
    var content: [UILabel] {
        return [
            makeContentLabel(text: country.capital?.joined(separator: ", ") ?? "N/A"),
            makeContentLabel(text: country.region),
            makeContentLabel(text: country.subregion ?? "N/A"),
            makeContentLabel(text: country.continents.joined(separator: ", ")),
            makeContentLabel(text: country.landlocked ? "Yes" : "No"),
            makeContentLabel(text: "\(country.area)"),
            makeContentLabel(text: country.borders?.joined(separator: ", ") ?? "N/A"),
            makeContentLabel(text: country.flag),
            makeContentLabel(text: country.altSpellings.joined(separator: ", ")),
            makeContentLabel(text: "\(country.population)"),
            makeContentLabel(text: country.timezones.joined(separator: ", ")),
            makeContentLabel(text: country.startOfWeek),
            makeContentLabel(text: country.fifa ?? "N/A")
        ]
    }
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = text
        return label
    }
    
    private func makeContentLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = text
        return label
    }
    
    func googleMapButtonTapped() {
        if let url = URL(string: country.maps.googleMaps) {
            UIApplication.shared.open(url)
        }
        else {
            print("Google Maps URL not found")
        }
    }
    
    func streetMapButtonTapped() {
        if let url = URL(string: country.maps.openStreetMaps) {
            UIApplication.shared.open(url)
        }
        else {
            print("OpenStreetMaps URL not found")
        }
    }
}
