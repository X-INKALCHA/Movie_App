//
//  MovieDetailCreditsTableViewCell.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

class MovieDetailCreditsTableViewCell: MovieDetailBaseTableViewCell {

    let directorLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let writerLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let actorsLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            return label
        }()
        
        let verticalStack : UIStackView = {
            let vStack = UIStackView()
            vStack.axis = .vertical
            vStack.translatesAutoresizingMaskIntoConstraints = false
            vStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            vStack.isLayoutMarginsRelativeArrangement = true
            return vStack
        }()
        
        override func prepareCellWithMovie(movie: FullMovie) {
            super.prepareCellWithMovie(movie: movie)
            setValuesForLabels(movie)
            addAllSubvies()
        }

        fileprivate func setValuesForLabels(_ movie: FullMovie) {
            if let director = movie.director {
                directorLabel.text = "Director: \(director)"
            }else {
                directorLabel.text = "Director: N/A"
            }
            
            if let writer = movie.writer {
                writerLabel.text = "Writer: \(writer)"
            }else {
                writerLabel.text = "Writer: N/A"
            }
            
            if let actors = movie.actors {
                actorsLabel.text = "Actors: \(actors)"
            }else {
                actorsLabel.text = "Actors: N/A"
            }
        }
        
        fileprivate func addAllSubvies() {
            addItemsToVerticalStackView()
            addVerticalStackViewToContentView()
        }
        
        fileprivate func addItemsToVerticalStackView() {
            verticalStack.addArrangedSubview(directorLabel)
            verticalStack.setCustomSpacing(10, after: directorLabel)
            verticalStack.addArrangedSubview(writerLabel)
            verticalStack.setCustomSpacing(10, after: writerLabel)
            verticalStack.addArrangedSubview(actorsLabel)
        }
        
        fileprivate func addVerticalStackViewToContentView() {
            //FInalising the Vertical Stack
            contentView.addSubview(verticalStack)
            applyAutoloyoutToVerticalStackView()
        }
        
        fileprivate func applyAutoloyoutToVerticalStackView() {
            verticalStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            verticalStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
            verticalStack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
            verticalStack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
