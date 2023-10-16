//
//  SectionHeaderReusableView.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import UIKit

final class SectionHeaderReusableView: UICollectionReusableView {
    
    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textColor = .vaganzaWhite
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with provider: SectionHeaderReusableViewProvider) {
        titleLabel.text = provider.title
    }
}

// MARK: - Helpers
private extension SectionHeaderReusableView {
    func setupView() {
        backgroundColor = .clear
        addSubview(titleLabel)
        
        titleLabel.setConstraint(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstraint: 10,
            leadingConstraint: 10,
            bottomConstraint: 10,
            trailingConstraint: 10
        )
    }
}
