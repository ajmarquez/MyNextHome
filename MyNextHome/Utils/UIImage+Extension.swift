//
//  File.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 27.06.21.
//

import Foundation
import UIKit


extension UIImage {
//    static func realStateImage(from realState: RealState, completion: @escaping (UIImage?) -> Void) {
//        let url = HomegateAPI.getImageURL(for: realState)
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//                print("realStateImage(from realState:) ->There was an error getting the Image")
//            }
//            guard let data = data else {
//                print("realStateImage(from realState:) ->There was an error getting the Image")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                completion(image)
//            }
//           
//        }.resume()
//    }
    
    //SPECIAL CASE: Load image using a re-formated URL for images
    static func loadImage(with url: String, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            let url = HomegateAPI.getImageURL(for: url)
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
}
