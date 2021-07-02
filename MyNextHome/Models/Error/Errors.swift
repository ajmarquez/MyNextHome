//
//  Errors.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 02.07.21.
//

import Foundation

enum NetworkError: LocalizedError {
    
    //Requests
    case statusError
    case fetchImageError
    
    //Endpoint
    case invalidURLComponents(String)
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .fetchImageError:
            return NSLocalizedString("Image could not be fetched",
                                     comment: "Plese check there's a valid address or that an image is actually available")
        case .invalidURLComponents(let components):
            let format = NSLocalizedString("Invalid URL Components", comment: "Please review it's a valid address")
            return String(format: format, String(components))
        case .statusError:
            return NSLocalizedString("Unsuccessful request made", comment: "")
        }
    }
}
