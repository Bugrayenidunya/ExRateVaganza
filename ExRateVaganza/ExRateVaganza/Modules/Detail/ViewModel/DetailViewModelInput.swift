//
//  DetailViewModelInput.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation

protocol DetailViewModelInput {
    var output: DetailViewModelOutput? { get set }
    
    func viewDidLoad()
}
