//
//  WebService.swift
//  MovieWorld
//
//  Created by Chuck.Zhou on 3/8/20.
//  Copyright © 2020 Haibo Family. All rights reserved.
//

import Foundation
import Combine


enum HTTPError: LocalizedError {
    case statusCode
    case post
}

struct WebService {
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.waitsForConnectivity = true
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
    private func createPublisher<T: Codable>(for url: URL) -> AnyPublisher<T, Error> {
        print("Pblisher URL: \(url)")
        return session.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    // print("Response: \(output.response)")
                    
                    do {
                        let resResponse = try self.decoder.decode(Response.self, from: output.data)
                        print("Result response:  \(resResponse)")
                    } catch {
                        print(error)
                    }
                    throw HTTPError.statusCode
                }
                
//                do {
//                    let result = try self.decoder.decode(T.self, from: output.data)
//                    // print("Result 1: \(result)")
//                } catch {
//                    print("ERROR: \(error)")
//                }
                return output.data
            }
            
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getSectionsPublisher() -> AnyPublisher<(TMDBMoviesResult, TMDBMoviesResult, TMDBMoviesResult, TMDBActorsResult), Error> {
        Publishers.Zip4(createPublisher(for: TMDBClient.Endpoints.nowPlayingMovies.url),
                        createPublisher(for: TMDBClient.Endpoints.popularMovies.url),
                        createPublisher(for: TMDBClient.Endpoints.upcomingMovies.url),
                        createPublisher(for: TMDBClient.Endpoints.popularActors.url))
                        .eraseToAnyPublisher()
    }
    
}

