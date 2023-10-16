//
//  HomeViewModelOutput.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

protocol HomeViewModelOutput: AnyObject, AlertShowable {
    func home(_ viewModel: HomeViewModelInput, didCreatedSections sections: [Section])
}
