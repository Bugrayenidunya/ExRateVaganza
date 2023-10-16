//
//  HomeViewModelTests.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import XCTest
@testable import ExRateVaganza

final class HomeViewModelTests: XCTestCase {
    
    // MARK: Properties
    private var viewModel: HomeViewModel!
    private var mockLoadingManager: MockLoadingManager!
    private var mockUserDefaultsManager: MockUserDefaultsManager!
    private var mockNetworkManager: MockNetworkManager!
    private var mockRouter: MockHomeRouting!
    private var mockPairAPI: MockPairAPI!
    private var mockRequestModel: MockGetAllPairsRequestModel!
    private var mockOutput: MockHomeViewModelOutput!
    
    override func setUpWithError() throws {
        super.setUp()
        
        mockLoadingManager = MockLoadingManager()
        mockUserDefaultsManager = MockUserDefaultsManager()
        mockNetworkManager = MockNetworkManager()
        mockRouter = MockHomeRouting()
        mockPairAPI = MockPairAPI()
        mockRequestModel = MockGetAllPairsRequestModel()
        mockOutput = MockHomeViewModelOutput()
        
        viewModel = HomeViewModel(
            router: mockRouter,
            loadingManager: mockLoadingManager,
            pairAPI: mockPairAPI,
            userDefaultsManager: mockUserDefaultsManager,
            requestModel: mockRequestModel
        )
        
        viewModel.output = mockOutput
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockLoadingManager = nil
        mockUserDefaultsManager = nil
        mockNetworkManager = nil
        mockRouter = nil
        mockPairAPI = nil
        mockRequestModel = nil
        mockOutput = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        // Act
        viewModel.viewDidLoad()
        
        // Assert
        XCTAssertTrue(mockPairAPI.fetchAllPairsCalled)
        XCTAssertTrue(mockLoadingManager.showCalled)
    }
    
    func testGetAllPairs() {
        // Arrange
        let mockResponse = generateMockGetAllPairsSuccessResponse()
        
        // Act
        mockPairAPI.mockFetchAllPairsResponse = mockResponse
        
        // Assert
        mockPairAPI.fetchAllPairs(request: mockRequestModel) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.success)
                XCTAssertNotEqual(response.data.count, 0)
                
            case .failure(let error):
                XCTFail("fetchAllPairs should not fail: \(error)")
            }
        }
    }
    
    func testFavoriteButtonPressed_addToFavorites() {
        // Arrange
        let mockPair = generateMockPair()
        
        // Act
        viewModel.updatePairs([mockPair])
        viewModel.favoriteButtonPressed(for: .zero)
        
        // Assert
        XCTAssertTrue(mockUserDefaultsManager.getCalled)
        XCTAssertTrue(mockUserDefaultsManager.setCalled)
        XCTAssertEqual(mockUserDefaultsManager.lastSetKey, Constant.UserDefault.favorites)
        XCTAssertTrue((mockUserDefaultsManager.lastSetValue as! [String]).contains(mockPair.pairNormalized))
    }
    
    func testFavoriteButtonPressed_removeFromFavorites() {
        // Arrange
        let mockPair = generateMockPair()
        
        // Act
        viewModel.updatePairs([mockPair])
        viewModel.favoriteButtonPressed(for: .zero)
        mockUserDefaultsManager.mockResponseValue = [mockPair.pairNormalized]
        viewModel.favoriteButtonPressed(for: .zero)
        
        // Assert
        XCTAssertTrue(mockUserDefaultsManager.getCalled)
        XCTAssertTrue(mockUserDefaultsManager.setCalled)
        XCTAssertEqual(mockUserDefaultsManager.lastSetKey, Constant.UserDefault.favorites)
        XCTAssertTrue(!(mockUserDefaultsManager.lastSetValue as! [String]).contains(mockPair.pairNormalized))
    }
    
    func testTitleForSection() {
        // Arrange
        let mockSection = generateMockSection()
        
        // Act
        viewModel.updateSections([mockSection])
        
        // Assert
        XCTAssertEqual(viewModel.title(for: .zero), mockSection.title)
    }
    
    func testDidSelectItemAt() {
        // Arrange
        let mockSection = generateMockSection()
        
        // Act
        viewModel.updateSections([mockSection])
        viewModel.didSelectItemAt(at: IndexPath(item: .zero, section: .zero))
        
        // Assert
        XCTAssertTrue(mockRouter.navigateToDetailCalled)
        
        switch mockSection.items.first! {
        case .pairs(let provider):
            XCTAssertEqual(mockRouter.mockKlineDataProvider?.pairNormalized, provider.pairNormalized)
        default:
            break
        }
    }
}

// MARK: = Helpers
private extension HomeViewModelTests {
    func generateMockGetAllPairsSuccessResponse() -> Result<GetAllPairsResponseModel, NetworkError> {
        let mockResponse: Result<GetAllPairsResponseModel, NetworkError>
        mockResponse = .success(GetAllPairsResponseModel(data: [.init(
            pair: "BTC/USD",
            pairNormalized: "BTC_USD",
            last: 75000.0,
            volume: 128.0,
            dailyPercent: 17,
            numeratorSymbol: "BTCUSD")
        ], success: true, message: nil, code: 200))
        return mockResponse
    }
    
    func generateMockPair() -> Pair {
        Pair(pair: "BTC/USD",
             pairNormalized: "BTC_USD",
             last: 75000.0,
             volume: 128.0,
             dailyPercent: 17,
             numeratorSymbol: "BTCUSD"
        )
    }
    
    func generateMockSection() -> Section {
        Section(items: [Item.pairs(HomePairCollectionViewCellDTO(
            isFavorited: true,
            pairName: "BTC/USD",
            pairNormalized: "BTC_USD",
            last: 75000.0,
            dailyPercent: 17,
            volume: 128.0,
            numeratorName: "BTCUSD")
        )],title: "Mock Section"
        )
    }
}
