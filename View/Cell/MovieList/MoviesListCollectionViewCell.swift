//
//  MoviesListCollectionViewCell.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

class MoviesListCollectionViewCell: UICollectionViewCell {
    var movieImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    var movieNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addAllSubviews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieNameLabel)
        self.applyAutolayoutToMovieImageView()
        self.applyAutolayoutToMovieNameLabel()
    }
    
    fileprivate func applyAutolayoutToMovieImageView() {
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
               movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
               movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
               movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    fileprivate func applyAutolayoutToMovieNameLabel() {
        movieNameLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 0).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 10).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0).isActive = true
    }
}
