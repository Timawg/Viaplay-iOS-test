//
//  SectionsViewModel.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation

protocol SectionsViewModelProtocol: ViewModelProtocol {
    var title: String { get set }
    var onDataRetrieved: (() -> Void)? { get set }
    var model: NetworkResponseModel { get set }
    init(title: String, url: URL?)
    func retrieveData(ignoreCache: Bool)
    func title(atIndex: Int) -> String
    func url(atIndex: Int) -> URL?
    func selectSection(url: URL, title: String)
}

final class SectionsViewModel: SectionsViewModelProtocol {
    
    @Injected(\.networkService) private var networkService: NetworkServiceProtocol
    private let baseURL = URL(string: "https://content.viaplay.se/ios-se")
    private let url: URL?
    weak var coordinator: Coordinator?
    var title: String
    var onDataRetrieved: (() -> Void)? = nil
    var model: NetworkResponseModel = .init(title: "", description: "", links: .init(viaplaySections: [])) {
        didSet {
            self.onDataRetrieved?()
        }
    }
    
    init(title: String = "Viaplay", url: URL? = nil) {
        self.title = title
        self.url = url ?? baseURL
    }
    
    func retrieveData(ignoreCache: Bool = false) {
        guard let url = url else {
            coordinator?.present(errorMessage: "Invalid URL")
            return
        }

        let cachePolicy: URLRequest.CachePolicy = ignoreCache ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
        networkService.request(method: .GET, url: url, cachePolicy: cachePolicy) { [weak self] (result: Result<NetworkResponseModel, NetworkError>)  in
            switch result {
            case .success(let model):
                self?.model = model
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.coordinator?.present(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func title(atIndex index: Int) -> String {
        return model.links.viaplaySections[index].title
    }
    
    func url(atIndex index: Int) -> URL? {
        return URL(string: model.links.viaplaySections[index].fixedHref)
    }
    
    func selectSection(url: URL, title: String) {
        coordinator?.coordinate(toUrl: url, withTitle: title)
    }
}
