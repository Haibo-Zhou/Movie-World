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

enum FailureReason: Error {
    case sessionFailed(error: HTTPError)
    case decodingFailed
    case other(Error)
}

struct WebService {
    
    struct Response: Codable {
        let statusMessage: String?
        let success: Bool?
        let statusCode: Int?
    }
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.waitsForConnectivity = true
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
//    private func createPublisher<T: Codable>(for url: URL) -> AnyPublisher<T, FailureReason> {
//        return session.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: T.self, decoder: decoder)
//            .mapError { error in
//                switch error {
//                case is Swift.DecodingError:
//                    return FailureReason.decodingFailed
//                case let urlError as URLError:
//                    return FailureReason.sessionFailed(error: urlError)
//                default:
//                    return .other(error)
//                }
//        }
//        .eraseToAnyPublisher()
//    }
    
    private func createPublisher<T: Codable>(for url: URL) -> AnyPublisher<T, FailureReason> {
        // print("Publisher URL: \(url)")
        return session.dataTaskPublisher(for: url)
            .tryMap { output in
//                print("OOOOOOOutput: \((output.response as? HTTPURLResponse)?.statusCode ?? 00)")
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    do {
                        let resResponse = try self.decoder.decode(Response.self, from: output.data)
                        print("Result response:  \(resResponse)")
                    } catch {
                        print(error)
                    }
                    throw HTTPError.statusCode
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return .decodingFailed
                case let httpError as HTTPError:
                    return .sessionFailed(error: httpError)
                default:
                    return .other(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getSectionsPublisher() -> AnyPublisher<(TMDBMoviesResult, TMDBMoviesResult, TMDBMoviesResult, TMDBActorsResult), FailureReason> {
        Publishers.Zip4(createPublisher(for: TMDBClient.Endpoints.nowPlayingMovies.url),
                        createPublisher(for: TMDBClient.Endpoints.popularMovies.url),
                        createPublisher(for: TMDBClient.Endpoints.upcomingMovies.url),
                        createPublisher(for: TMDBClient.Endpoints.popularActors.url))
                        .eraseToAnyPublisher()
    }
    
    // MARK: Used for SingleMovieView
    func getMovieDetailPublisher(for id: Int) -> AnyPublisher<Movie, FailureReason> {
        createPublisher(for: TMDBClient.Endpoints.movieDetail(id).url)
    }
    
    func getMovieInfomPublisher(for id: Int) -> AnyPublisher<(Credits, TMDBImagesResult, TMDBMoviesResult), FailureReason> {
        Publishers.Zip3(createPublisher(for: TMDBClient.Endpoints.credits(id).url),
                        createPublisher(for: TMDBClient.Endpoints.movieImages(id).url),
                        createPublisher(for: TMDBClient.Endpoints.movieRecommendations(id).url))
                        .eraseToAnyPublisher()
    }
    
    // MARK: Used for SinglePersonView
    func getPersonDetailPublisher(for id: Int) -> AnyPublisher<Actor, FailureReason> {
        createPublisher(for: TMDBClient.Endpoints.personDetail(id).url)
    }
    
    func getPersonInfoPublisher(for id: Int) -> AnyPublisher<(MovieCredits, PersonImages), FailureReason> {
        Publishers.Zip(createPublisher(for: TMDBClient.Endpoints.movieCredits(id).url),
                       createPublisher(for: TMDBClient.Endpoints.personImages(id).url))
                       .eraseToAnyPublisher()
    }
    
    func getPaginatedPublisher(for section: HomeSection, page: Int) -> AnyPublisher<TMDBMoviesResult, FailureReason> {
        createPublisher(for: TMDBClient.Endpoints.paginatedMovies(section, page).url)
    }
    
    func getPaginatedActorPublisher(for page: Int) -> AnyPublisher<TMDBActorsResult, FailureReason> {
        createPublisher(for: TMDBClient.Endpoints.paginatedActors(page).url)
    }
    
    func getSearchResultsPublisher(for name: String, page: Int) -> AnyPublisher<TMDBMoviesResult, FailureReason> {
        createPublisher(for: TMDBClient.Endpoints.searchMovies(name, page).url)
    }
}

