//
//  HeaderView.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import UIKit

final class HeaderView: UIView {
    
    private var titleLabel: UILabel
    private var descriptionLabel: UILabel

    override init(frame: CGRect) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        super.init(frame: frame)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    func set(title: String, description: String) {
        self.titleLabel.text = title
        self.titleLabel.sizeToFit()
        self.descriptionLabel.text = description
        self.descriptionLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
