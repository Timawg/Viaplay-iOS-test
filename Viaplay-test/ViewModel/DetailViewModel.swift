//
//  DetailViewModel.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-16.
//

import Foundation

protocol DetailViewModelProtocol: ViewModelProtocol {
    var title: String { get set }
    var content: (title: String, description: String) { get set }
    var onDataRetrieved: (() -> Void)? { get set }
    init(title: String, url: URL?)
    func retrieveData(ignoreCache: Bool)
}

final class DetailViewModel: DetailViewModelProtocol {

    @Injected(\.networkService) private var networkService: NetworkServiceProtocol
    private var url: URL?
    weak var coordinator: Coordinator?
    var title: String
    var content = (title: "", description: "") {
        didSet {
            DispatchQueue.main.async {
                self.onDataRetrieved?()
            }
        }
    }
    var onDataRetrieved: (() -> Void)? = nil

    init(title: String, url: URL?) {
        self.title = title
        self.url = url
    }
    
    func retrieveData(ignoreCache: Bool) {
        guard let url = url else {
            coordinator?.present(errorMessage: "Invalid URL")
            return
        }
        let cachePolicy: URLRequest.CachePolicy = ignoreCache ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
        networkService.request(method: .GET, url: url, cachePolicy: cachePolicy) { [weak self] (result: Result<NetworkResponseModel, NetworkError>) in
            switch result {
            case .success(let model):
                self?.content = (title: model.title, description: model.description)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.coordinator?.present(errorMessage: error.localizedDescription, handler: {
                        self?.retrieveData(ignoreCache: ignoreCache)
                    })
                }
            }
        }
    }
}
