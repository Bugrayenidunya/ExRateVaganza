//
//  HomeController.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

final class HomeController: UIViewController {
    
    // MARK: Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    // MARK: Properties
    private let viewModel: HomeViewModelInput
    
    private var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    private lazy var dataSource = generateDatasource()
    
    private enum Constant {
        static let headerKind = "header"
        static let sectionInset = 2.0
        static let half = 0.5
        static let full = 1.0
        static let headerHeight = 44.0
        static let cellHeight = 56.0
        static let leadingSpace = 16.0
        static let firstGroupWidth = 156.0
        static let itemSpace = 10.0
    }
    
    // MARK: Views
    private lazy var collectionView: UICollectionView = {
        let compositionalLayout = generateCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.register(HomeFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: HomeFavoriteCollectionViewCell.identifier)
        collectionView.register(HomePairCollectionViewCell.self, forCellWithReuseIdentifier: HomePairCollectionViewCell.identifier)
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.identifier
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    init(viewModel: HomeViewModelInput) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - HomeViewModelOutput
extension HomeController: HomeViewModelOutput {
    func home(_ viewModel: HomeViewModelInput, didCreatedSections sections: [Section]) {
        self.applySnapshot(sections: sections)
    }
}

// MARK: - HomePairCollectionViewCellDelegate
extension HomeController: HomePairCollectionViewCellDelegate {
    func home(_ pairCell: HomePairCollectionViewCell, didPressedFavoriteButtonWith provider: HomePairCollectionViewCellProvider) {
        viewModel.favoriteButtonPressed(with: provider.pairName)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeController: UICollectionViewDelegate {

}

// MARK: - Helpers
private extension HomeController {
    func commonInit() {
        setupViews()
        setupSupplementryView()
        setupNavigationTitle()
        viewModel.viewDidLoad()
    }
    
    func setupNavigationTitle() {
        navigationItem.title = "ExRateVaganza"
        
        if let navigationController {
            let textAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.vaganzaWhite,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)
            ]
            
            navigationController.navigationBar.titleTextAttributes = textAttributes
        }
    }
    
    func setupViews() {
        view.backgroundColor = .vaganzaDarkerBlue
        view.addSubview(collectionView)
        
        collectionView.setConstraint(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            topConstraint: .zero,
            leadingConstraint: .zero,
            bottomConstraint: .zero,
            trailingConstraint: .zero
        )
    }
    
    /// Applies new data to dataSource
    func applySnapshot(sections: [Section], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    /// Generates `UICollectionViewDiffableDataSource`
    func generateDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellProvider) -> UICollectionViewCell? in
                
                switch cellProvider {
                case .favorites(let provider):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFavoriteCollectionViewCell.identifier, for: indexPath) as? HomeFavoriteCollectionViewCell else { return nil }
                    cell.configure(with: provider)
                    return cell
                    
                case .pairs(let provider):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePairCollectionViewCell.identifier, for: indexPath) as? HomePairCollectionViewCell else { return nil }
                    cell.delegate = self
                    cell.configure(with: provider)
                    return cell
                }
            })
        
        return dataSource
    }
    /// Setups `Section`
    func setupSupplementryView() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return .init(frame: .zero) }
            
            if indexPath.section == .zero {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: indexPath) as? SectionHeaderReusableView
                view?.backgroundColor = .clear
                view?.titleLabel.text = self.viewModel.title(for: indexPath.section)
                
                return view
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: indexPath) as? SectionHeaderReusableView
            view?.backgroundColor = .clear
            view?.titleLabel.text = self.viewModel.title(for: indexPath.section)
            
            return view
        }
    }
    /// Generates `UICollectionViewCompositionalLayout` with given items, group, header and section
     func generateCompositionalLayout() -> UICollectionViewCompositionalLayout {
         let favoritesSection = generateFavoritesSection()
         let pairsSection = generatePairsSection()
         
         let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
             return sectionIndex == .zero ? favoritesSection : pairsSection
         }

         return layout
     }
    /// Generates `NSCollectionLayoutItem` with given dimensions
    func generateLayoutItems() -> NSCollectionLayoutItem {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.cellHeight)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: Constant.sectionInset, leading: Constant.sectionInset, bottom: Constant.sectionInset, trailing: Constant.sectionInset)
        
        return item
    }
    /// Generates `NSCollectionLayoutBoundarySupplementaryItem` with given dimensions
    func generateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemDimension = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.headerHeight)
        )
        return .init(layoutSize: headerItemDimension, elementKind: UICollectionView.elementKindSectionHeader,  alignment: .top)
    }
    /// Generates `NSCollectionLayoutSection` with given group
    func generateSection(for group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constant.sectionInset,
            leading: Constant.sectionInset,
            bottom: Constant.sectionInset,
            trailing: Constant.sectionInset
        )
        
        section.boundarySupplementaryItems = [generateHeader()]
        
        return section
    }
    
    func generateFavoritesSection() -> NSCollectionLayoutSection {
        let firstItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.cellHeight)
        )

        let firstItem = NSCollectionLayoutItem(layoutSize: firstItemSize)
        firstItem.contentInsets = .init(top: .zero, leading: Constant.leadingSpace, bottom: .zero, trailing: .zero)
        
        let firstGroupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(Constant.firstGroupWidth),
            heightDimension: .estimated(Constant.cellHeight)
        )
        let firstGroup = NSCollectionLayoutGroup.horizontal(layoutSize: firstGroupSize, subitems: [firstItem])
        firstGroup.interItemSpacing = .fixed(Constant.itemSpace)
        let firstSection = generateSection(for: firstGroup)
        firstSection.orthogonalScrollingBehavior = .continuous
        
        return firstSection
    }
    
    func generatePairsSection() -> NSCollectionLayoutSection {
        let secondItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.cellHeight)
        )

        let secondtItem = NSCollectionLayoutItem(layoutSize: secondItemSize)
        let secondGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.cellHeight)
        )
        
        let secondGroup = NSCollectionLayoutGroup.vertical(layoutSize: secondGroupSize, subitems: [secondtItem])
        let secondSection = generateSection(for: secondGroup)
        
        return secondSection
    }
}
