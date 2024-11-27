//
//  File.swift
//  hackathon
//
//  Created by Mykhailo Artemiev on 27/11/2024.
//

import Foundation
import Vapor
import Fluent
import Crypto

func RegisterRequest(req: Request) async throws -> Response {
    var response: Response = Response()
    print(req.body)
    let user = try req.content.decode(User.self)
    print(user)
    let checkUsername = try await User.query(on: req.db).filter(\.$username == user.username).first()
    if let _ = checkUsername {
        response = GenrerateResponse(dictionary: ["status": "dropped"])
    } else {
        user.password = try Bcrypt.hash(user.password)
        try await user.save(on: req.db)
        let createdUser = try await User.query(on: req.db).filter(\.$username == user.username).first()
        if let _ = createdUser {
            response = GenrerateResponse(dictionary: ["status": "approved", "token": createdUser!.id!.uuidString])
        }
    }
    return response
}

func LoginRequest(req: Request) async throws -> Response {
    var response: Response = Response()
    let loginInfo = try req.content.decode(User.self)
    let loggedUser = try await User.query(on: req.db).filter(\.$username == loginInfo.username).first()
    if loggedUser != nil, try Bcrypt.verify(loginInfo.password, created: loggedUser!.password){
        response = GenrerateResponse(dictionary: ["status": "approved", "token": loggedUser!.id!.uuidString])
    } else {
        response = GenrerateResponse(dictionary: ["status": "dropped"])
    }
    return response
}

func RecordRequest(req: Request) async throws -> Response {
    let request: [String: Any] = try decodeRequest(req: req)
    let userUUID = try await ValidateUser(username: request["username"] as! String, password: request["password"] as! String)
    guard userUUID != nil else {
        return GenrerateResponse(dictionary: ["status": "dropped"])
    }
    let userMood = UserMood(userId: userUUID!, mood: request["mood"] as! String)
    try await userMood.save(on: app.db)
    return GenrerateResponse(dictionary: <#T##[String : Any]#>)
}
