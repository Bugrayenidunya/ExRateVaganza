//
//  DetailViewModelOutput.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation

protocol DetailViewModelOutput: AnyObject {
    func detail(_ viewModel: DetailViewModelInput, didFetchKlineChartData provider: KlineChartDataProvider)
    func detail(_ viewModel: DetailViewModelInput, didUpdateNavigationTitle title: String)
}
