//
//  FavoriteButton.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 30.06.21.
//

import Foundation
import UIKit

class CellButton: UIButton {
    
    typealias DidTapButton = (CellButton) -> ()
    var favState: Bool = false  {
        didSet{
            configImageState()
        }
    }

//    var didTouchUpInside: DidTapButton? {
//        didSet {
//            if didTouchUpInside != nil {
//                addTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
//            } else {
//                removeTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
//            }
//        }
//    }

      // MARK: - Actions
//
//    @objc func didTouchUpInside(_ sender: UIButton) {
//        //favState = !favState
//        imageState()
//        if let handler = didTouchUpInside {
//            handler(self)
//            favState = !favState
//        }
//    }
    
    func configImageState() {
        if favState {
            self.setImage(UIImage(named: Constants.Images.heartFull), for: .normal)
        } else {
            self.setImage(UIImage(named: Constants.Images.heartEmpty), for: .normal)
        }
    }
    
}
