//
//  IdentifierProtocol.swift
//  Movie_App
//
//  Created by SravsRamesh on 15/06/20.
//  Copyright © 2020 SravsRamesh. All rights reserved.
//

import UIKit

protocol IdentifierProtocol { }

extension IdentifierProtocol where Self : UIView {
    static var identifierValue : String {
        return String(describing: self)
    }
}

extension UIView : IdentifierProtocol { }
