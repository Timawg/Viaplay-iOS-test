//
//  HeaderView.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {

    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupDescription()
        setupStackview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    private func setupDescription() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
    }
    
    func setupStackview() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
        stackView.constraintToFillSuperView()
    }
    
    func set(title: String, description: String) {
        self.titleLabel.text = title
        self.titleLabel.sizeToFit()
        self.descriptionLabel.text = description
        self.descriptionLabel.sizeToFit()
    }
}
