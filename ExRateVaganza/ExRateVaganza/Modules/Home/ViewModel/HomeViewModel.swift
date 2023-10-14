//
//  HomeViewModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

final class HomeViewModel: HomeViewModelInput {
    
    // MARK: Properties
    private let router: HomeRouting
    private let loadingManager: Loading
    private let alertManager: AlertShowable
    private let pairAPI: PairFetchable
    private let userDefaultsManager: UserDefaultsManagable
    private let requestModel: GetAllPairsRequestModel
    
    private var sections: [Section] = []
    private var pairs: [Pair] = []
    
    weak var output: HomeViewModelOutput?
    
    // MARK: Init
    init(router: HomeRouting, loadingManager: Loading, alertManager: AlertShowable, pairAPI: PairFetchable, userDefaultsManager: UserDefaultsManagable, requestModel: GetAllPairsRequestModel) {
        self.router = router
        self.loadingManager = loadingManager
        self.alertManager = alertManager
        self.pairAPI = pairAPI
        self.userDefaultsManager = userDefaultsManager
        self.requestModel = requestModel
    }
    
    func viewDidLoad() {
        getAllPairs(with: requestModel)
    }
    
    func favoriteButtonPressed(with pairName: String) {
        guard let index = pairs.firstIndex(where: { $0.pair == pairName }) else { return }
        let pair = pairs[index]
        isFavorited(pair) ? removeFromFavorites(pair) : addToFavorites(pair)
    }
    
    func sectionHasItems(_ index: Int) -> Bool {
        sections[index].items.isEmpty
    }
    
    func title(for section: Int) -> String {
        sections[section].title
    }
    
    func didSelectItemAt(at indexPath: IndexPath) {
        guard let item = getItem(at: indexPath) else { return }
        let klineDataRequestDTO = createKlineDataRequest(for: item)
        router.navigateToDetail(klineDataRequestDTO)
    }
}

// MARK: - Helpers
private extension HomeViewModel {
    func getItem(at indexPath: IndexPath) -> Item? {
        sections[indexPath.section].items[indexPath.row]
    }

    func createKlineDataRequest(for item: Item) -> KlineDataRequestDTO {
        var symbol: String = .empty
        var pairNormalized: String = .empty
        
        switch item {
        case .favorites(let provider):
            symbol = provider.pairName
            pairNormalized = provider.pairNormalized
            
        case .pairs(let provider):
            symbol = provider.pairName
            pairNormalized = provider.pairNormalized
        }
        
        return KlineDataRequestDTO(
            from: Int(Date.getOpeningHourTimeInterval),
            to: Int(Date.getClosingTimeForDate),
            resolution: 15,
            symbol: symbol,
            pairNormalized: pairNormalized
        )
    }
    
    func createSection(with pairs: [Pair]) -> Section {
        var dtos: [HomePairCollectionViewCellProvider] = []
        var items: [Item] = []
        
        pairs.forEach { pair in
            let dto = HomePairCollectionViewCellDTO(
               isFavorited: isFavorited(pair),
               pairName: pair.pair,
               pairNormalized: pair.pairNormalized,
               last: pair.last,
               dailyPercent: pair.dailyPercent,
               volume: pair.volume,
               numeratorName: pair.numeratorSymbol
            )
            
            dtos.append(dto)
        }
        
        dtos.forEach { dto in
            let item = Item.pairs(dto)
            items.append(item)
        }
        
        let section = Section(items: items, title: "Pairs")
        return section
    }
    
    func createSection(with favorites: [String]) -> Section {
        guard !favorites.isEmpty else { return .init(items: [], title: .empty) }
        
        var dtos: [HomeFavoriteCollectionViewCellProvider] = []
        var items: [Item] = []
        
        let favoritedPairs = pairs.filter { pair in
            favorites.contains(pair.pairNormalized)
        }
        
        favoritedPairs.forEach { pair in
            let dto = HomeFavoriteCollectionViewCellDTO(
                pairName: pair.pair,
                last: pair.last,
                dailyPercent: pair.dailyPercent,
                pairNormalized: pair.pairNormalized
            )
            
            dtos.append(dto)
        }
        
        dtos.forEach { dto in
            let item = Item.favorites(dto)
            items.append(item)
        }
        
        let section = Section(items: items, title: "Favorites")
        return section
    }
    
    func getAllPairs(with request: GetAllPairsRequestModel) {
        loadingManager.show()
        
        pairAPI.fetchAllPairs(request: request) {[weak self] result in
            guard let self else { return }
            
            self.loadingManager.hide()
            
            switch result {
            case .success(let response):
                self.pairs = response.data
                
                DispatchQueue.main.async {
                    self.updateSections()
                }
                
            case .failure(let error):
                self.alertManager.showAlert(with: error)
            }
        }
    }
    
    func addToFavorites(_ pair: Pair) {
        var favorites = getFavoritedPairNames()
        favorites.append(pair.pairNormalized)
        userDefaultsManager.set(value: favorites, with: Constant.UserDefault.favorites)
        updateSections()
    }
    
    func removeFromFavorites(_ pair: Pair) {
        var favorites = getFavoritedPairNames()
        favorites = favorites.filter({ $0 != pair.pairNormalized })
        userDefaultsManager.set(value: favorites, with: Constant.UserDefault.favorites)
        updateSections()
    }
    
    func getFavoritedPairNames() -> [String] {
        userDefaultsManager.get(with: Constant.UserDefault.favorites, type: [String].self) ?? []
    }
    
    func isFavorited(_ pair: Pair) -> Bool {
        getFavoritedPairNames().contains(where: { $0 == pair.pairNormalized })
    }
    
    func updateSections() {
        let favoritesSection = createSection(with: getFavoritedPairNames())
        let pairsSection = createSection(with: self.pairs)
        
        sections.removeAll()
        sections.append(favoritesSection)
        sections.append(pairsSection)
        
        output?.home(self, didCreatedSections: sections)
    }
}
