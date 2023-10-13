//
//  Section.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

struct Section: Hashable {
    let items: [Item]
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.title == rhs.title
    }
}
