//
//  MovieDetailPosterTableViewCell.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

class MovieDetailPosterTableViewCell: MovieDetailBaseTableViewCell {

    //UI elements for First Section
        let movieImageView : UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let playButton : UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        override func prepareCellWithMovie(movie: FullMovie) {
            super.prepareCellWithMovie(movie: movie)
            addAllSubvies()
        }
        //Constructing First Section
        fileprivate func addAllSubvies() {
            contentView.addSubview(movieImageView)
            contentView.addSubview(playButton)
            playButton.setTitle("", for: .normal)
            playButton.setImage(UIImage.init(named: "play"), for: .normal)
            applyAutolayoutToMovieImageView()
            applyAutolayoutToPlayButton()
        }
        
        fileprivate func applyAutolayoutToMovieImageView() {
            movieImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            movieImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
            movieImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
            movieImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        
        fileprivate func applyAutolayoutToPlayButton() {
            playButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
            playButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
            playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
    }
