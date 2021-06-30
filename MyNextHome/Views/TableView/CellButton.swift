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

    var didTouchUpInside: DidTapButton? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(_:)), for: .touchUpInside)
            }
        }
    }

      // MARK: - Actions
    
    @objc func didTouchUpInside(_ sender: UIButton) {
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
    
}
