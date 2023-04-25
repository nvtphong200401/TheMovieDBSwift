//
//  NetworkClient.swift
//  TheMovieDBSwift
//
//  Created by exe-macm1 on 25/04/2023.
//

import Foundation
import Combine

enum MovieCategory: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
}

protocol NetworkClientProtocol {
//    func getMovies(forCategory category: MovieCategory, page: Int) -> AnyPublisher<MovieListResponse, Error>
//    func getMovie(withID id: Int) -> AnyPublisher<Movie, Error>
    func send<T: Decodable>(param: ParamProtocol) async throws -> T
}

class NetworkClient: NetworkClientProtocol {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "a7e38c80a0efc42034dfb5c8b95a72cb"
    private let session: URLSession
    private let jsonDecoder = JSONDecoder()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T: Decodable>(param: ParamProtocol) async throws -> T {
        var components = URLComponents(string: baseURL + param.getPath())
        components?.queryItems = param.getQueryParam().map { URLQueryItem(name: $0.0, value: $0.1) }
        components?.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let (data, response) = try await session.data(for: request)
        // Check for network errors
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        do {
            let result = try jsonDecoder.decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.invalidResponse
        }
    }
    
//    func getMovies(forCategory category: MovieCategory, page: Int) -> AnyPublisher<MovieListResponse, Error> {
//        print("get movie")
//        guard let url = buildURL(path: "/movie/\(category.rawValue.lowercased())", queryItems: [("page", "\(page)"), ("api_key", apiKey)]) else {
//            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
//        }
//        
//        var request = URLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        print("attaced header")
//        return session.dataTaskPublisher(for: request)
//            .tryMap { data, response in
//
//                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//                    throw NetworkError.invalidResponse
//                }
//
//                return data
//            }
//            .decode(type: MovieListResponse.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//    
//    func getMovie(withID id: Int) -> AnyPublisher<Movie, Error> {
//        
//        guard let url = buildURL(path: "/movie/\(id)", queryItems: [("api_key", apiKey)]) else {
//            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
//        }
//        print("URL: \(url)")
//        var request = URLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        
//        return session.dataTaskPublisher(for: request)
//            .tryMap { data, response in
//                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//                    throw NetworkError.invalidResponse
//                }
//                return data
//            }
//            .decode(type: Movie.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
    
    private func buildURL(path: String, queryItems: [(String, String)] = []) -> URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}
