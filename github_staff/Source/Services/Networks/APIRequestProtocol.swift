//
//  APIRequestProtocol.swift
//  github_staff

import Alamofire

protocol APIRequestProtocol {
    var method: HTTPMethod { get }
    var path: String { get }
    var header: Parameters? { get }
    var params: Parameters? { get }
    var body: Parameters? { get }
}

extension APIRequestProtocol {

    var method: HTTPMethod { return .get }
    var path: String { return "" }
    var header: Parameters? { return nil }
    var params: Parameters? { return nil }
    var body: Parameters? { return nil }

    private var defaultHeader: Parameters? {
        var param = ["Content-Type": "application/json"]
        param["Authorization"] = "token \(Enviroment.token)"
        return param
    }

    var request: URLRequest {
        var url = URL(string: Enviroment.host)!
        url.appendPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setHeaders(defaultHeader)
        request.setHeaders(header)
        request.setParams(params)
        request.setBody(body)
        return request
    }

    func asURLRequest() throws -> URLRequest {
        return request
    }
}
