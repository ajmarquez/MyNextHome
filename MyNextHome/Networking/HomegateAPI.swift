//
//  HomegateAPI.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 26.06.21.
//

import Foundation
import Combine

protocol NetworkService {
}

class HomegateAPI: NetworkService {
    var urlSession = URLSession.shared
    
    func loadRealStates() -> AnyPublisher<RealStateResponse, Error> {
        urlSession.publisher(for: Endpoint.realStateList.url)
    }

}

extension HomegateAPI {
    static func getImageURL(for item: RealState) -> URL {
        
        guard let mainUrl = URL(string: item.imageURL) else {
            preconditionFailure("ImageURL from RealState Item could not be loaded")
        }
        
        let workingPath = mainUrl.path
        
        //Define the correct route for the image
        var workingURL = URLComponents()
        workingURL.scheme = "https"
        workingURL.host = "homegate.ch"
        workingURL.path = workingPath
        
        guard let finalURL = workingURL.url else {
            preconditionFailure(
                "Invalid URL Components: \(workingURL)"
            )
        }
        return finalURL
    }
}
