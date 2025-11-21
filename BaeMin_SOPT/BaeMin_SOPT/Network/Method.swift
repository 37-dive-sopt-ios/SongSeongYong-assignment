//
//  Method.swift
//  BaeMin_SOPT
//
//  Created by 송성용 on 11/21/25.
//


import Foundation

/// HTTP 메서드 (Moya의 Method와 동일!)
public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
