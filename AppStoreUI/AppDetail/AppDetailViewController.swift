//
//  AppDetailViewController.swift
//  AppStoreUI
//
//  Created by Jaeyoung Choi on 9/13/24.
//

import UIKit

typealias AppDetailDataSource = UICollectionViewDiffableDataSource<AppDetailSection, AppDetailItem>
typealias AppDetailSnapshot = NSDiffableDataSourceSnapshot<AppDetailSection, AppDetailItem>

class AppDetailViewController: UIViewController {
    
    let uiModel: AppUIModel
    
    private var dataSource: AppDetailDataSource?
    
    init(uiModel: AppUIModel) {
        self.uiModel = uiModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        updateUI()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 1:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.6),
                    heightDimension: .fractionalWidth(1.2)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(200)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(200)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                section = NSCollectionLayoutSection(group: group)
            }
            
            return section
        }
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        
        setupDataSource(collectionView: collectionView)
    }
    
    private func setupDataSource(collectionView: UICollectionView) {
        let headerCellRegistration = UICollectionView.CellRegistration<AppHeaderCollectionViewCell, AppUIModel> { cell, _, item in
            cell.setData(item)
        }
        
        let screenshotCellRegistration = UICollectionView.CellRegistration<AppScreenshotCollectionViewCell, String> { cell, _, item in
            cell.setData(item)
        }
        
        let descCellRegistration = UICollectionView.CellRegistration<AppDescriptionCollectionViewCell, String> { cell, _, item in
            cell.setData(item)
        }
        
        dataSource = AppDetailDataSource(collectionView: collectionView) { cv, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .title(let model):
                return cv.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: model)
            case .screenshot(let model):
                return cv.dequeueConfiguredReusableCell(using: screenshotCellRegistration, for: indexPath, item: model)
            case .desc(let model):
                return cv.dequeueConfiguredReusableCell(using: descCellRegistration, for: indexPath, item: model)
            }
        }
    }
    
    private func updateUI() {
        guard let dataSource else { return }
        
        var snapshot = AppDetailSnapshot()
        
        snapshot.appendSections([.title, .screenshots, .desc])
        
        snapshot.appendItems([.title(uiModel)], toSection: .title)
        snapshot.appendItems(uiModel.appScreenshotURLs.map{ .screenshot($0) }, toSection: .screenshots)
        snapshot.appendItems([.desc(uiModel.appDescription)], toSection: .desc)
        
        dataSource.apply(snapshot)
    }
}
