//
//  BaseService.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/16/25.
//

import Foundation

class BaseService {
    /// 공통 API 요청 함수 - HTTP 요청 수행 후 디코딩된 응답을 반환
    /// - Parameters:
    ///   - method: HTTP 메서드 (.get, .post 등)
    ///   - baseUrl: API의 Base URL
    ///   - path: API 경로
    ///   - task: 요청에 포함될 파라미터 또는 requestBody
    ///   - headerField: HTTP 헤더 설정
    ///   - responseType: 응답으로 받을 타입 (디코딩 대상)
    /// - Returns: 응답을 BaseResponse<T> 형태로 디코딩하여 반환합니다
    func request<T: Decodable>(
        method: HTTPMethod,
        baseUrl: String,
        path: String,
        task: NetworkTask,
        headerField: HeaderField,
        responseType: T.Type
    ) async throws -> BaseResponseBody<T> {
        // 1️⃣ urlRequest 생성
        let urlRequest = try makeRequest(
            method: method,
            baseUrl: baseUrl,
            path: path,
            task: task,
            headerField: headerField
        )
        
        // 2️⃣ Request 요청 로그 출력
        NetworkLogger.logRequest(urlRequest)
        
        do {
            // 3️⃣ 실제 네트워크 요청 수행
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            // 4️⃣ 응답 로그 출력
            NetworkLogger.logResponse(data: data, response: response)
            
            // 5️⃣ HTTP 응답 형식 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            
            // 6️⃣ 상태 코드에 따른 예외 처리
            let statusCode = httpResponse.statusCode

            guard 200..<300 ~= statusCode else {
                if statusCode == 404 {
                    throw NetworkError.notFoundError
                } else if statusCode == 500 {
                    throw NetworkError.internalServerError
                } else {
                    throw NetworkError.responseError
                }
            }
            
            // 7️⃣ JSON 디코딩
            do {
                return try JSONDecoder().decode(BaseResponseBody<T>.self, from: data)
            } catch {
                throw NetworkError.responseDecodingError
            }
            
        } catch {
            // 8️⃣ 에러 로깅 & 에러 던짐
            NetworkLogger.logError(error)
            throw error
        }
    }
}

// MARK: - Make Request

extension BaseService {
    private func makeRequest(
        method: HTTPMethod,
        baseUrl: String,
        path: String,
        task: NetworkTask,
        headerField: HeaderField
    ) throws -> URLRequest {
        
        // URL path 설정
        let fullPath = baseUrl + path
        guard var urlComponents = URLComponents(string: fullPath) else {
            throw NetworkError.invalidURLComponents
        }

        var bodyData: Data?
        var url: URL?
        
        // Task 분기 처리
        switch task {
        case .requestPlain:
            url = urlComponents.url
            
        case .requestParameters(let parameters, let encoding):
            switch encoding {
            case .queryString:
                let queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                urlComponents.queryItems = queryItems
                url = urlComponents.url
            }

        case .requestJSONEncodable(let encodable):
            url = urlComponents.url
            do {
                let encoder = JSONEncoder()
                bodyData = try encoder.encode(encodable)
            } catch {
                throw NetworkError.requestEncodingError
            }
        }
        
        guard let url = url else {
            throw NetworkError.invalidURLString
        }

        // HTTP Method 설정
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = bodyData
        
        // Headers 설정
        headerField.keyValue?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}

// MARK: - Enums

extension BaseService {
    /// HTTPMethod
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    /// Header
    enum HeaderField {
        case contentTypeJSON
        case phoneNumber(number: String)
        
        var keyValue: [String: String]? {
            switch self {
            case .contentTypeJSON:
                return ["Content-Type": "application/json"]
            case .phoneNumber(number: let number):
                return ["Content-Type": "application/json", "phoneNumber": String(number)]
            }
        }
    }
    
    /// NetworkTAsk
    enum NetworkTask {
        case requestPlain
        case requestParameters(parameters: [String : Any], encoding: ParameterEncoding)
        case requestJSONEncodable(encodable: Encodable)
    }
    
    enum ParameterEncoding {
        case queryString
    }
}
