//
//  HomeCollectionViewCell.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import UIKit

protocol HomePairCollectionViewCellDelegate: AnyObject {
    func home(_ pairCell: HomePairCollectionViewCell, didPressedFavoriteButtonWith provider: HomePairCollectionViewCellProvider)
}

final class HomePairCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier = "HomePairCollectionViewCell"
    private var provider: HomePairCollectionViewCellProvider?
    
    weak var delegate: HomePairCollectionViewCellDelegate?
    
    private let favoriteIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
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
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let volumeAndNumeratorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vaganzaGray
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .vaganzaGray
        return view
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupFavoriteTapAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with provider: HomePairCollectionViewCellProvider) {
        self.provider = provider
        
        pairNameLabel.text = provider.pairNormalized.formattedPairNormalized
        lastPriceLabel.text = provider.last.stringValueWithThreeFloatingPoints
        dailyPercentLabel.text = "%\(provider.dailyPercent.stringValueWithTwoFloatingPoints)"
        volumeAndNumeratorNameLabel.text = "\(provider.volume.stringValueWithTwoFloatingPoints) \(provider.numeratorName)"
        setIsFavorited(provider.isFavorited)
        setDailyPercentColor(provider.dailyPercent)
    }
}

// MARK: - Private
private extension HomePairCollectionViewCell {
    func setupFavoriteTapAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoritePressed))
        favoriteIconImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func favoritePressed() {
        guard let provider else { return }
        delegate?.home(self, didPressedFavoriteButtonWith: provider)
    }
    
    func setDailyPercentColor(_ dailyPercent: Double) {
        dailyPercentLabel.textColor = dailyPercent < .zero ? .vaganzaRed : .vaganzaGreen
    }
    
    func setIsFavorited(_ isFavorited: Bool) {
        favoriteIconImageView.tintColor = isFavorited ? .systemOrange : .vaganzaWhite
    }
    
    func setupViews() {
        backgroundColor = .clear
        addSubViews([favoriteIconImageView, pairNameLabel, lastPriceLabel, dailyPercentLabel, volumeAndNumeratorNameLabel, separatorView])
        
        favoriteIconImageView.setConstraint(
            top: topAnchor,
            leading: leadingAnchor,
            topConstraint: 8,
            leadingConstraint: 16,
            width: 24,
            height: 24
        )
        
        pairNameLabel.setConstraint(
            leading: favoriteIconImageView.trailingAnchor,
            leadingConstraint: 16,
            centerY: favoriteIconImageView.centerYAnchor
        )
        
        dailyPercentLabel.setConstraint(
            top: topAnchor,
            trailing: trailingAnchor,
            topConstraint: 8,
            trailingConstraint: 16
        )
        
        lastPriceLabel.setConstraint(
            trailing: dailyPercentLabel.leadingAnchor,
            trailingConstraint: 8,
            centerY: dailyPercentLabel.centerYAnchor
        )
        
        volumeAndNumeratorNameLabel.setConstraint(
            top: lastPriceLabel.bottomAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstraint: 8,
            bottomConstraint: 8,
            trailingConstraint: 16
        )
        
        separatorView.setConstraint(
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            leadingConstraint: .zero,
            bottomConstraint: .zero,
            trailingConstraint: .zero,
            height: 0.5
        )
    }
}
