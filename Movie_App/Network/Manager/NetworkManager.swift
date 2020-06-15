//
//  NetworkManager.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import Foundation
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

//typealias completionBlock = (_ movie: [Movie]?,_ error: String?)->()

struct NetworkManager {
    private init() {}
    static let sharedManager : NetworkManager = NetworkManager()
    let movieRouter = Router<MovieAPI>()
    
    func getMoviesListByName(enteredString: String, page: Int, completion: @escaping (_ movies: MovieAPIResponse?, _ error: String?)->()){
        movieRouter.request(.getListByName(name: enteredString, page: page)) { (data, response, error) in
                        if error != nil {
                completion(nil, "please check your network connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let apiResponse = try decoder.decode(MovieAPIResponse.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch{
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getMovieWithID(movieID: String, completion: @escaping (_ movie: FullMovie?, _ error: String?)->()){
        movieRouter.request(.getMovieWithID(movieID: movieID)) { (data, response, error) in
            if error != nil {
                completion(nil, "please check your network connection")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let apiResponse = try decoder.decode(FullMovie.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch{
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
