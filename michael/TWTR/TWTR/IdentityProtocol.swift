//
//  IdentityProtocol.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/15/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import Foundation

protocol IdentityProtocol
{
    static func id()-> String

}

extension IdentityProtocol {
    
    static func id()->String {
        return String(self)
    }
    
}