//
//  NetworkLogger.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import Foundation

enum NetworkLogger {
    
    static func logRequest(_ urlRequest: URLRequest) {
        guard let url = urlRequest.url?.absoluteString else {
            print("--> 유효하지 않은 요청")
            return
        }
        
        let method = urlRequest.httpMethod ?? "메소드값이 nil입니다."
        var log = """
        ----------------------------------------------------
        1️⃣[\(method)] \(url)
        ----------------------------------------------------
        """
        
        if let headers = urlRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("\n📦 Headers: \(headers)")
        }
        
        if let body = urlRequest.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            log.append("\n📨Body: \(bodyString)")
        }
        
        log.append("\n------------------- END \(method) -------------------")
        print(log)
    }
    
    static func logResponse(data: Data, response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let url = httpResponse.url?.absoluteString ?? "nil"
        let statusCode = httpResponse.statusCode
        
        var log = """
        ------------------- Response가 도착했습니다. -------------------
        2️⃣[\(statusCode)] \(url)
        Status Code: [\(statusCode)]
        URL: \(url)
        response:
        """
        
        if let body = String(data: data, encoding: .utf8) {
            log.append("\n3️⃣\(body)")
        }
        
        log.append("\n------------------- END HTTP -------------------")
        print(log)
    }
    
    static func logError(_ error: Error) {
        let message: String
        
        if let networkError = error as? NetworkError {
            message = networkError.description
        } else {
            message = error.localizedDescription
        }
        
        let log = """
        ❌ 네트워크 오류 발생
        📌 \(message)
        ------------------- END ERROR -------------------
        """
        print(log)
    }
}
