//
//  Protocols.swift
//  InternetShop
//
//  Created by Kiri4of on 08.12.2022.
//

import Foundation

protocol LoadingProtocol {
    func update(loading: Bool)
}

protocol presentVCDelegate: AnyObject { 
    func sendData(menu: Menu)
}
