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

func RegisterRequest(req: Request) async throws-> Response {
    var response: Response = Response()
    let user = try req.content.decode(User.self)
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
