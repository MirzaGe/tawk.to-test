//
//  SearchMasterViewModel.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/**
 Protocol of `SearchMasterViewModel`.
 */
protocol SearchMasterDelegate: BaseViewModelDelegate {
    func showDetail(with result: Result)
}

/**
 The viewmodel that the `SearchMasterViewController` owns.
 */
class SearchMasterViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private var mediaType = "movie"
    private var searchTerm = "star"
    private weak var delegate: SearchMasterDelegate?
    
    var searchResult: SearchResult?
    
    // MARK: Visibilities
    
    /// Should the loader be hidden?
    var loaderIsHidden = BehaviorRelay<Bool>(value: true)
    /// Should the tableView be hidden? I.e. hidden whilst loader is visible
    var tableViewIsHidden = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Functions
    
    /// Function to re-do searching. Called by the refresh control
    func refresh() {
        self.search(self.searchTerm, country: AppConfig.country, media: self.mediaType)
    }
    
    /// Do searching... call `SearchService`.
    private func search(_ term: String, country: String, media: String) {
        self.loaderIsHidden.accept(false)
        self.tableViewIsHidden.accept(true)
        
        searchProvider.request(.search(term: term, country: country, media: media)) { (result) in
            self.loaderIsHidden.accept(true)
            self.tableViewIsHidden.accept(false)
            
            switch result {
            case let .success(response):
                if response.statusCode == 200,
                    let searchResult = try? JSONDecoder().decode(SearchResult.self, from: response.data) {
                    self.searchResult = searchResult
                    self.delegate?.reloadData()
                    return
                }
                
                // TODO: handle error further...
                self.showError("Data error")
                
            case let .failure(error):
                self.showError(error.localizedDescription)
            }
        }
    }
    
    // MARK: Overrides
    
    init(searchMasterController: SearchMasterDelegate?) {
        super.init()
        
        self.delegate = searchMasterController
        self.search(self.searchTerm, country: AppConfig.country, media: self.mediaType)
    }
    
    /// A controller lifecycle method
    func viewDidLoad() {
        if let storedResult = AppDefaults.getObjectWithKey(.lastViewedResult, type: Result.self) {
            self.delegate?.showDetail(with: storedResult)
            AppDefaults.removeDefaultsWithKey(.lastViewedResult)
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchMasterViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let results = self.searchResult?.results {
            let data = results[indexPath.row]
            // Store result to defaults for last viewing.
            AppDefaults.store(data, key: .lastViewedResult)
            // Show the detail screen
            self.delegate?.showDetail(with: data)
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchMasterViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: DataTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as? DataTableViewCell
        
        if cell == nil {
            cell = DataTableViewCell()
        }
        
        if let results = self.searchResult?.results {
            let data = results[indexPath.row]
            let type = data.cellType
            cell?.setupCell(data: data, type: type)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResult?.resultCount ?? 0
    }
}
