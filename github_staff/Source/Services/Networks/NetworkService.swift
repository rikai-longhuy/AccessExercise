//
//  NetworkService.swift
//  github_staff

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class NetworkService {
    
    private static var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 30.0
        return config
    }
    private static var sessionManager = Session(configuration: configuration)
    
    public class func request<T: Codable>(_ request: URLRequestConvertible, type: T.Type) -> Observable<T?> {
        return sessionManager.rx
            .request(urlRequest: request)
            .catch ({ _ in
                // TODO:
                return Observable.empty()
            }).responseJSON().map({ response -> Data? in
                    return response.data
            }).mapObject(type: T.self)
    }
}
