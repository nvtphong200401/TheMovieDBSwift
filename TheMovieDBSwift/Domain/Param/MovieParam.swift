//
//  MovieParam.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation
class ListMovieParam : ParamProtocol {
    let category: MovieCategory
    let page: Int
    init(category: MovieCategory, page: Int) {
        self.category = category
        self.page = page
    }
    func getPath() -> String {
        "/movie/\(category.rawValue.lowercased())"
    }
    func getQueryParam() -> [(String, String)] {
        [("page", "\(page)")]
    }
}

class MovieParam : ParamProtocol {
    let id: Int
    init(id: Int) {
        self.id = id
    }
    func getPath() -> String {
        "/movie/\(id)"
    }
    
    func getQueryParam() -> [(String, String)] {
        []
    }
    
    
}
