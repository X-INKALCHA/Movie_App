//
//  Movie.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import Foundation
struct MovieAPIResponse : Codable {
    var totalResults : String?
    var Search : [ShortMovie]?
    var Response : String?
}

struct ShortMovie : Codable {
    var title : String?
    var year : String?
    var imdbID : String?
    var movieType : String?
    var poster : String?
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case movieType = "Type"
        case poster = "Poster"
    }
}

struct FullMovie : Codable {
    var title : String?
    var year : String?
    var released : String?
    var runtime : String?
    var genre : String?
    var director : String?
    var writer : String?
    var actors : String?
    var plot : String?
    var language : String?
    var country : String?
    var awards : String?
    var poster : String?
    var imdbRating : String?
    var imdbID : String?
    var imdbVotes : String?
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating
        case imdbID
        case imdbVotes
    }
}
