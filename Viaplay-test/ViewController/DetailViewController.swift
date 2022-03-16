//
//  DetailViewController.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-16.
//

import UIKit

protocol DetailViewControllerProtocol: ViewControllerProtocol {
    var viewModel: DetailViewModelProtocol { get set }
}

final class DetailViewController: UIViewController, DetailViewControllerProtocol {
    
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
    var _viewModel: ViewModelProtocol
    
    var viewModel: DetailViewModelProtocol {
        get {
            guard let viewModel = _viewModel as? DetailViewModel else {
                fatalError("Programming error")
            }
            return viewModel
        }
        set {
            _viewModel = newValue
        }
    }

    required init(viewModel: ViewModelProtocol) {
        self._viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .systemBackground
        view.tintColor = .label
        setupStackview()
        viewModel.onDataRetrieved = { [weak self, viewModel] in
            self?.set(title: viewModel.content.title,
                      description: viewModel.content.description)
        }
        viewModel.retrieveData(ignoreCache: false)
    }
    
    private func set(title: String, description: String) {
        titleLabel.text = viewModel.content.title
        descriptionLabel.text = viewModel.content.description
    }
    
    func setupStackview() {
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        view.addSubview(stackView)
        stackView.constrainToCenter()
    }
}
