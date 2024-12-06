//
//  MoyaServiceHelper.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//


import Moya
import Alamofire

class MoyaServiceHelper<T: TargetType> {
    
    // MARK:- Properties
    
    let provider: MoyaProvider<T>
    
    // MARK:- Init
    
    init(type: NetworkServiceType = .live) {
        let serviceType = type == .live ? MoyaProvider<T>.neverStub : MoyaProvider<T>.immediatelyStub
        let formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: { data in
            data.prettyString as String? ?? "## Cannot map data to String ##"
        })
        let loggerConfig = NetworkLoggerPlugin.Configuration(formatter: formatter, logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<T>(stubClosure: serviceType, plugins: [networkLogger])
    }
    
    deinit {
        print("deinit: \(Self.self)")
    }
    
    // MARK: - Methods
    
    func request<R: Codable>(target: T, completion: @escaping(Result<R, Error>) -> Void) {
        defaultRequest(target: target) { (result: Swift.Result<R, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func defaultRequest<R: Codable>(target: T, completion: @escaping (Result<R, Error>) -> Void) {
        guard NetworkReachabilityManager()?.isReachable ?? false else {
            let error = NetworkError(code: 0, message: "NetworkError")
            completion(.failure(error))
            return
        }
        
        print("🤩 Network Call: \(T.self), \(target.path)")
        provider.request(target) { result in
            switch result {
            case .success(let value):
                guard value.statusCode == 200 else {
                    let error = NetworkError(code: value.statusCode, message: value.description)
                    print("🤯 Decoder Failure in \(T.self) for \(R.self) \nError: \(error)")
                    break
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(R.self, from: value.data)
                    completion(.success(response))
                } catch(let decodeError) {
                    let error = NetworkError(code: 0, message: "somethingwentwrongtryagainlater")
                    print("🤯 Decoder Failure in \(T.self) for \(R.self) \nError: \(decodeError)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("🤯 Network Call Failure For \(T.self) \nError: \(error)")
                completion(.failure(error))
            }
        }
    }
}
