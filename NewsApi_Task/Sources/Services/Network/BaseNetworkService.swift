//
//  BaseNetworkService.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import Foundation


// MARK: - Custom Error
enum CustomError: Error {
    case invalidURL
    case decodingError(String)
    case networkError(String)
}

// MARK: - BaseRequestServiceProtocol
protocol BaseRequestServiceProtocol {
    func getDataModel<DataModel: Decodable>(url: URL?,
                                            model: DataModel.Type,
                                            completion: @escaping (Result<DataModel, CustomError>) -> Void)
}

// MARK: - BaseRequestService
final class BaseRequestService: BaseRequestServiceProtocol {
    
    private let session = URLSession.shared
    
    // MARK: - Protocol Methods
    func getDataModel<DataModel: Decodable>(
        url: URL?,
        model: DataModel.Type,
        completion: @escaping (Result<DataModel, CustomError>) -> Void
    ) {
        guard let url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.networkError("HTTP status code: \(httpResponse.statusCode)")))
                return
            }
            
            guard let data else {
                completion(.failure(.networkError("No data received")))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }
        
        task.resume()
    }
}
