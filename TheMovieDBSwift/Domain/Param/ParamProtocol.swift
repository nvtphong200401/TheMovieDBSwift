//
//  ParamProtocol.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation

protocol ParamProtocol {
    func getPath() -> String
    func getQueryParam() -> [(String, String)]
}
