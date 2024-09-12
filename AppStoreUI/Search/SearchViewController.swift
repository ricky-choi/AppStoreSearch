//
//  SearchViewController.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import UIKit
import Combine

typealias SearchDataSource = UICollectionViewDiffableDataSource<SearchSection, SearchItem>
typealias SearchSnapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>

public class SearchViewController: UIViewController {
    
    private var viewModel: SearchViewModel
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private var dataSource: SearchDataSource?
    
    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupSearchController()
        
        bindOutput()
        
        viewModel.recent(term: "")
    }

}

private extension SearchViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        let listConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfig)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        
        setupDataSource(collectionView: collectionView)
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func bindOutput() {
        viewModel.recents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.updateUI(recents: items, apps: [])
            }
            .store(in: &subscriptions)
        
        viewModel.apps
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.updateUI(recents: [], apps: items)
            }
            .store(in: &subscriptions)
    }
    
    func updateUI(recents: [RecentUIModel], apps: [AppUIModel]) {
        guard let dataSource else { return }
        
        var snapshot = SearchSnapshot()
        
        if !recents.isEmpty {
            // recents only
            snapshot.appendSections([.recents])
            snapshot.appendItems(recents.map { .recent($0) })
        }
        if !apps.isEmpty {
            // apps only
            snapshot.appendSections([.apps])
            snapshot.appendItems(apps.map { .app($0) })
        }
        
        dataSource.apply(snapshot)
    }
    
    private func setupDataSource(collectionView: UICollectionView) {
        let recentCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, RecentUIModel> { cell, _, item in
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = item
            
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
        }
        
        let appCellRegistration = UICollectionView.CellRegistration<AppCollectionViewCell, AppUIModel> { cell, _, item in
            cell.setData(item)
        }
        
        dataSource = SearchDataSource(collectionView: collectionView) { cv, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .recent(let model):
                return cv.dequeueConfiguredReusableCell(using: recentCellRegistration, for: indexPath, item: model)
            case .app(let model):
                return cv.dequeueConfiguredReusableCell(using: appCellRegistration, for: indexPath, item: model)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        viewModel.recent(term: searchText.trimmingCharacters(in: CharacterSet.whitespaces))
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(term: searchBar.text ?? "")
    }
}

extension SearchViewController: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .recent(let recentUIModel):
            // search
            viewModel.search(term: recentUIModel)
        case .app(let appUIModel):
            // show detail
            let appDetail = AppDetailViewController(uiModel: appUIModel)
            navigationController?.pushViewController(appDetail, animated: true)
        }
    }
}
