//
//  DetailController.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import DGCharts
import UIKit

final class DetailController: UIViewController {

    // MARK: Properties
    private let viewModel: DetailViewModelInput
    
    // MARK: Views
    private let lineChartView: LineChartView = {
        let lineChart = LineChartView()
        return lineChart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        viewModel.viewDidLoad()
    }
    
    init(viewModel: DetailViewModelInput) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - DetailViewModelOutput
extension DetailController: DetailViewModelOutput {
    func detail(_ viewModel: DetailViewModelInput, didFetchKlineChartData provider: KlineChartDataProvider) {
        setupChartData(with: provider)
    }
    
    func detail(_ viewModel: DetailViewModelInput, didUpdateNavigationTitle title: String) {
        navigationItem.title = title
    }
}

// MARK: - Helpers
private extension DetailController {
    func setupChartData(with provider: KlineChartDataProvider) {
        let chartDataEntries = createChartDataEntries(with: provider)
        let dataSet = createChartDataSet(with: chartDataEntries)
        let chartData = createLineChartData(with: dataSet)
        lineChartView.data = chartData
    }
    
    func createLineChartData(with dataSet: LineChartDataSet) -> LineChartData {
        let chartData = LineChartData(dataSet: dataSet)
        chartData.setDrawValues(false)
        return chartData
    }
    
    func createLinearGradientFill() -> LinearGradientFill? {
        let gradientColors = [UIColor.cyan.withAlphaComponent(0.5).cgColor, UIColor.cyan.withAlphaComponent(0.001).cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            return nil
        }
        return LinearGradientFill(gradient: gradient, angle: 90)
    }
    
    func createChartDataSet(with chartDataEntries: [ChartDataEntry]) -> LineChartDataSet {
        let dataSet = LineChartDataSet(entries: chartDataEntries)
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.drawFilledEnabled = true
        dataSet.fill = createLinearGradientFill()
        dataSet.cubicIntensity = 0.2
        return dataSet
    }
    
    func createChartDataEntries(with provider: KlineChartDataProvider) -> [ChartDataEntry] {
        zip(provider.x, provider.y).map { x, y in
            ChartDataEntry(x: Double(x), y: y)
        }
    }
    
    func commonInit() {
        setupViews()
        configureChart()
    }
    
    func configureChart() {
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.chartDescription.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = true
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = true
        lineChartView.rightAxis.drawZeroLineEnabled = false
        lineChartView.rightAxis.labelTextColor = .vaganzaWhite
        lineChartView.rightAxis.drawAxisLineEnabled = false
    }
    
    func setupViews() {
        lineChartView.xAxis.enabled = false
        lineChartView.backgroundColor = .vaganzaBlue.withAlphaComponent(0.05)
        
        view.backgroundColor = .vaganzaDarkerBlue
        view.addSubview(lineChartView)
        
        lineChartView.setConstraint(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            topConstraint: 72,
            leadingConstraint: 8,
            trailingConstraint: 8,
            height: 232
        )
    }
}
