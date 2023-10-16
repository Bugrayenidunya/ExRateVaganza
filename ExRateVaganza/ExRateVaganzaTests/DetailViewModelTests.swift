//
//  DetailViewModelTests.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import XCTest
@testable import ExRateVaganza

final class DetailViewModelTests: XCTestCase {
    
    // MARK: Properties
    private var viewModel: DetailViewModel!
    private var mockLoadingManager: MockLoadingManager!
    private var mockAlertManager: MockAlertManager!
    private var mockPairAPI: MockPairAPI!
    private var mockKlineDataRequestProvider: MockKlineDataRequestProvider!
    private var mockGetKlineDataRequestModel: MockGetKlineDataRequestModel!
    private var mockOutput: MockDetailViewModelOutput!
    
    override func setUpWithError() throws {
        mockLoadingManager = MockLoadingManager()
        mockAlertManager = MockAlertManager()
        mockPairAPI = MockPairAPI()
        mockKlineDataRequestProvider = generateMockKlineDataRequestProvider()
        mockGetKlineDataRequestModel = .init(from: mockKlineDataRequestProvider.from, to: mockKlineDataRequestProvider.to, resolution: mockKlineDataRequestProvider.resolution, symbol: mockKlineDataRequestProvider.symbol)
        mockOutput = MockDetailViewModelOutput()
        
        viewModel = DetailViewModel(loadingManager: mockLoadingManager, alertManager: mockAlertManager, pairAPI: mockPairAPI, klineDataProvider: mockKlineDataRequestProvider)
        viewModel.output = mockOutput
    }
    
    override func tearDownWithError() throws {
        mockLoadingManager = nil
        mockAlertManager = nil
        mockPairAPI = nil
        mockKlineDataRequestProvider = nil
        mockGetKlineDataRequestModel = nil
        viewModel = nil
        mockOutput = nil
    }
    
    func testViewDidLoad() {
        // Arrange
        let mockResponse = generateMockKlineDataSuccessResponse()
        
        // Act
        mockPairAPI.mockFetchKlineDataResponse = mockResponse
        viewModel.viewDidLoad()
        
        // Assert
        self.mockPairAPI.fetchKlineData(request: self.mockGetKlineDataRequestModel) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(self.mockLoadingManager.showCalled)
                XCTAssertTrue(self.mockPairAPI.fetchKlineDataCalled)
                XCTAssertTrue(self.mockOutput.detailViewModelDidFetchKlineChartDataCalled)
                XCTAssertEqual(self.mockOutput.lastFetchedKlineChartData!.x, response.time.map({ Int($0) }))
                XCTAssertEqual(self.mockOutput.lastFetchedKlineChartData!.y, response.close)
                
            case .failure(let error):
                XCTFail("fetchKlineData should not fail: \(error)")
            }
        }
    }
}

// MARK: - Helpers
private extension DetailViewModelTests {
    func generateMockKlineDataSuccessResponse() -> Result<GetKlineDataResponseModel, NetworkError> {
        let mockResponse: Result<GetKlineDataResponseModel, NetworkError>
        mockResponse = .success(GetKlineDataResponseModel(close: [1,2,3,4], time: [0,15,30,45]))
        return mockResponse
    }
    
    func generateMockKlineDataRequestProvider() -> MockKlineDataRequestProvider {
        MockKlineDataRequestProvider(from: Int(Date.getOpeningHourTimeInterval), to: Int(Date.getClosingTimeForDate), resolution: 15, symbol: "BTCUSD", pairNormalized: "BTC_USD")
    }
}
