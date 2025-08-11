//
//  ResponseError.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import Foundation
//{
//"success": false,
//"status_code": 6,
//"status_message": "Invalid id: The pre-requisite id is invalid or not found."
//}

struct ResponseError: Codable, Error {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

