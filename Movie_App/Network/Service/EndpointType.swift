//
//  EndpointType.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import Foundation
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
