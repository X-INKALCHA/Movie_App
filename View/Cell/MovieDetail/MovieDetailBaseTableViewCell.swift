//
//  MovieDetailBaseTableViewCell.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

class MovieDetailBaseTableViewCell: UITableViewCell {

    var movie = FullMovie()
        
        public func prepareCellWithMovie(movie: FullMovie) {
            self.movie = movie
        }
    }
