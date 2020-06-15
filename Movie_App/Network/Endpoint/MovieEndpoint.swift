//
//  MovieEndpoint.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import Foundation
public enum MovieAPI {
    case getListByName(name: String, page: Int)
    case getMovieWithID(movieID: String)
}

extension MovieAPI : EndPointType {
    var baseURLPath : String {
        return "http://www.omdbapi.com/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: baseURLPath) else {fatalError("baseURL could not be configured")}
        return url
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getListByName(let name, let page):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters:
                ["s" : name,
                 "page" : page,
                 "plot" : "full",
                 "type" : "movie",
                 "apikey" : "b9bd48a6"])
        case .getMovieWithID(let movieID):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters:
                ["i" : movieID,
                 "apikey" : "b9bd48a6"])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
