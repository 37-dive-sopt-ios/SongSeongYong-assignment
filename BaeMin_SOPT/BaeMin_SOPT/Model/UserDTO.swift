//
//  UserDTO.swift
//  BaeMin_SOPT
//
//  Created by 송성용 on 11/21/25.
//

import Foundation

/// 사용자 정보 응답 모델
public struct UserResponse: Decodable {
    public let id: Int
    public let username: String
    public let name: String
    public let email: String
    public let age: Int
    public let status: String
}

/// 회원가입 요청 모델
public struct RegisterRequest: Encodable {
    public let username: String
    public let password: String
    public let name: String
    public let email: String
    public let age: Int
    
    public init(username: String, password: String, name: String, email: String, age: Int) {
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.age = age
    }
}

/// 로그인 요청 모델
public struct LoginRequest: Encodable {
    public let username: String
    public let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

/// 로그인 응답 모델
public struct LoginResponse: Decodable {
    public let userId: Int
    public let message: String
}

/// 개인정보 수정 요청 모델
public struct UpdateUserRequest: Encodable {
    public let name: String?
    public let email: String?
    public let age: Int?
    
    public init(name: String?, email: String?, age: Int?) {
        self.name = name
        self.email = email
        self.age = age
    }
}


