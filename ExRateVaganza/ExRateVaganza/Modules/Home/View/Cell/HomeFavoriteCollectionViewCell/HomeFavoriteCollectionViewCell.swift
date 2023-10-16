//
//  HomeFavoriteCollectionViewCell.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import UIKit

final class HomeFavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    private let pairNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vaganzaWhite
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let lastPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vaganzaWhite
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let dailyPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vaganzaGreen
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with provider: HomeFavoriteCollectionViewCellProvider) {
        pairNameLabel.text = provider.pairNormalized.formattedPairNormalized
        lastPriceLabel.text = provider.last.stringValueWithThreeFloatingPoints
        dailyPercentLabel.text = "%\(provider.dailyPercent.stringValueWithTwoFloatingPoints)"
        setDailyPercentColor(provider.dailyPercent)
    }
}

// MARK: - Helpers
private extension HomeFavoriteCollectionViewCell {
    func setDailyPercentColor(_ dailyPercent: Double) {
        dailyPercentLabel.textColor = dailyPercent < .zero ? .vaganzaRed : .vaganzaGreen
    }
    
    func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .vaganzaBlue
        addSubViews([pairNameLabel, lastPriceLabel, dailyPercentLabel])
        
        pairNameLabel.setConstraint(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            topConstraint: 8,
            leadingConstraint: 8,
            trailingConstraint: 8
        )
        
        lastPriceLabel.setConstraint(
            top: pairNameLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            topConstraint: 8,
            leadingConstraint: 8,
            trailingConstraint: 8
        )
        
        dailyPercentLabel.setConstraint(
            top: lastPriceLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstraint: 8,
            leadingConstraint: 8,
            bottomConstraint: 8,
            trailingConstraint: 8
        )
    }
}
