//
//  File.swift
//  BaeMin_SOPT
//
//  Created by 송성용 on 11/21/25.
//

import Foundation

/// User 관련 API 엔드포인트
/// Moya의 TargetType 과 비슷하게 구현함
public enum UserAPI {
    case register(RegisterRequest)           // POST /api/v1/users - 회원가입
    case login(LoginRequest)                 // POST /api/v1/auth/login - 로그인
    case getUser(userId: Int)                // GET /api/v1/users/{id} - 사용자 조회
    case updateUser(userId: Int, request: UpdateUserRequest)  // PATCH /api/v1/users/{id} - 사용자 수정
    case deleteUser(userId: Int)             // DELETE /api/v1/users/{id} - 사용자 삭제
}

extension UserAPI: TargetType {

    /// 기본 URL
    public var baseURL: String {
        // SOPT 세미나 서버 URL (4주차 임시 개방)
        // TODO: 실제 배포 시에는 xcconfig 파일이나 환경 변수로 관리하세요
        return "http://15.164.129.239"
    }

    /// API 경로
    public var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .getUser(let userId):
            return "/api/v1/users/\(userId)"
        case .updateUser(let userId, _):
            return "/api/v1/users/\(userId)"
        case .deleteUser(let userId):
            return "/api/v1/users/\(userId)"
        }
    }

    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .getUser:
            return .get
        case .updateUser:
            return .patch
        case .deleteUser:
            return .delete
        }
    }

    /// The type of HTTP task to be performed.
    public var task: HTTPTask {
        switch self {
        case .register(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)

        case .login(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)
            
        case .getUser:
            // GET 요청은 바디 없음
            return .requestPlain
            
        case .updateUser(_, let request):
            // PATCH 요청, JSON 바디 전송
            return .requestJSONEncodable(request)
            
        case .deleteUser:
            // DELETE 요청은 바디 없음
            return .requestPlain
        }
    }

    /// 헤더 (Moya와 동일 - 필요시 오버라이드)
    public var headers: [String: String]? {
        // Content-Type은 Task에서 자동 설정되므로 여기서는 nil 반환
        return nil
    }
}

// MARK: - Convenience Methods

extension UserAPI {
    /// 회원가입 API 요청 헬퍼
    public static func performRegister(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let request = RegisterRequest(
            username: username,
            password: password,
            name: name,
            email: email,
            age: age
        )
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.register(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }

    /// 로그인 API 요청 헬퍼
    public static func performLogin(
        username: String,
        password: String,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> LoginResponse {
        let request = LoginRequest(username: username, password: password)
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<LoginResponse> = try await provider.request(UserAPI.login(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    /// 사용자 정보 조회 API 요청 헬퍼
    public static func performGetUser(
        userId: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.getUser(userId: userId))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    /// 사용자 정보 수정 API 요청 헬퍼
    public static func performUpdateUser(
        userId: Int,
        name: String?,
        email: String?,
        age: Int?,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let request = UpdateUserRequest(name: name, email: email, age: age)
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.updateUser(userId: userId, request: request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    /// 사용자 삭제 API 요청 헬퍼
    public static func performDeleteUser(
        userId: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws {
        // BaseResponse로 감싸진 응답 디코딩 (EmptyResponse)
        let _: BaseResponse<EmptyResponse> = try await provider.request(UserAPI.deleteUser(userId: userId))
        // 삭제는 응답 데이터가 없으므로 성공 여부만 확인
    }
}
