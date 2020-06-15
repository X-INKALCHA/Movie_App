//
//  MovieDetailTitleTableViewCell.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

class MovieDetailTitleTableViewCell: MovieDetailBaseTableViewCell {

      let titleLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        
        let yearLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            return label
        }()
          
        override func prepareCellWithMovie(movie: FullMovie) {
            super.prepareCellWithMovie(movie: movie)
            addAllSubvies()
        }
        
        //Constructing First Section
        fileprivate func addAllSubvies() {
            contentView.addSubview(titleLabel)
            contentView.addSubview(yearLabel)
            if let title = movie.title {
                titleLabel.text = title
            }
            if let year = movie.year {
                yearLabel.text = "Year: \(year)"
            }
            applyAutolayoutToYearlabel()
            applyAutolayoutToTitlelabel()
        }
            
        fileprivate func applyAutolayoutToYearlabel() {
            yearLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            yearLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            yearLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        }

        fileprivate func applyAutolayoutToTitlelabel() {
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: yearLabel.topAnchor, constant: 0).isActive = true
        }
    }
