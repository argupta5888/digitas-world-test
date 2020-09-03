//
//  BaseProtocol.swift
//  DigitasWorld
//
//  Created by ashok on 02/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import Foundation

protocol Presentable: AnyObject {
    func willLoadData()
    func didLoadData()
    func didFail(error: CustomError)
}

protocol iPresenter {
    init(view: Presentable)
    func initInteractor()
}
