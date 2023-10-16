//
//  HomeViewModelInput.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

protocol HomeViewModelInput {
    var output: HomeViewModelOutput? { get set }
    
    func viewDidLoad()
    func favoriteButtonPressed(for index: Int)
    func title(for section: Int) -> String
    func didSelectItemAt(at indexPath: IndexPath)
}
