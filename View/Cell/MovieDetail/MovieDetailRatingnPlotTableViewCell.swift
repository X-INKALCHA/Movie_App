//
//  MovieDetailRatingnPlotTableViewCell.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

class MovieDetailRatingnPlotTableViewCell: MovieDetailBaseTableViewCell {

   //UIElements for Second Section
        let genereLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        let timeLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        let ratingLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        let plotLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .justified
            return label
        }()
        
        let scoreLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        let votesLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        let popularityLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()
        
        
        let horizontalFirstStack : UIStackView = {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.distribution = .fill
            hStack.alignment = .top
            hStack.translatesAutoresizingMaskIntoConstraints = false
            return hStack
        }()
        
        let horizontalSecondStack : UIStackView = {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.distribution = .fill
            hStack.alignment = .top
            hStack.translatesAutoresizingMaskIntoConstraints = false
            return hStack
        }()
        
        let horizontalThirdStack : UIStackView = {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.distribution = .fill
            hStack.alignment = .top
            hStack.translatesAutoresizingMaskIntoConstraints = false
            return hStack
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
            self.setValuesForLabel(movie)
            addAllSubvies()
        }
        
        fileprivate func setValuesForLabel(_ movie: FullMovie) {
            if let genere = movie.genre {
                self.genereLabel.text = "Genere: \n \(genere)"
            }else{
                self.genereLabel.text = "N/A"
            }
            
            if let time = movie.runtime {
                self.timeLabel.text = "Time: \n \(time)"
            }else{
                self.timeLabel.text = "N/A"
            }
            
            if let rating = movie.imdbRating {
                self.ratingLabel.text = "Rating *\n \(rating)"
            }else{
                self.ratingLabel.text = "N/A"
            }
            
            if let plot = movie.plot {
                self.plotLabel.text = "Synopisys: \n \t \(plot)"
            }else{
                self.plotLabel.text = "Synopisys: \n \t N/A"
            }
            
            if let score = movie.imdbRating {
                self.scoreLabel.text = "Score: \n \(score)"
            }else{
                self.scoreLabel.text = "N/A"
            }
            
            if let votes = movie.imdbVotes {
                self.votesLabel.text = "Votes: \n \(votes)"
            }else{
                self.votesLabel.text = "N/A"
            }
            
            if let popularity = movie.imdbRating {
                self.popularityLabel.text = "Popularity \n Up: \(popularity)"
            }else{
                self.popularityLabel.text = "N/A"
            }
        }
        
        fileprivate func addAllSubvies() {
            addItemsToFirstHorizontalStackView()
            addItemsToSecondHorizontalStackView()
            addItemsToThirdHorizontalStackView()
            addItemsToVerticalStackView()
            addVerticalStackViewToContentView()
        }
        
        fileprivate func addItemsToFirstHorizontalStackView() {
            //First Horizontal Stack
            horizontalFirstStack.addArrangedSubview(genereLabel)
            horizontalFirstStack.addArrangedSubview(timeLabel)
            horizontalFirstStack.addArrangedSubview(ratingLabel)
        }

        fileprivate func addItemsToSecondHorizontalStackView() {
            //Second Horizontal Stack
            horizontalSecondStack.addArrangedSubview(plotLabel)
        }
        
        fileprivate func addItemsToThirdHorizontalStackView() {
            //Third Horizontal Stack
            horizontalThirdStack.addArrangedSubview(scoreLabel)
            horizontalThirdStack.addArrangedSubview(votesLabel)
            horizontalThirdStack.addArrangedSubview(popularityLabel)
        }
        
        fileprivate func addItemsToVerticalStackView() {
            verticalStack.addArrangedSubview(horizontalFirstStack)
            verticalStack.setCustomSpacing(20, after: horizontalFirstStack)
            verticalStack.addArrangedSubview(horizontalSecondStack)
            verticalStack.setCustomSpacing(20, after: horizontalSecondStack)
            verticalStack.addArrangedSubview(horizontalThirdStack)
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
