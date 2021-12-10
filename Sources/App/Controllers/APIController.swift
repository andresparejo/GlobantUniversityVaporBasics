//
//  APIController.swift
//  
//
//  Created by Eduardo Andres Rodriguez Parejo on 10/20/21.
//

import Foundation
import Vapor

struct ApiController: RouteCollection {
    func boot(routes: RoutesBuilder) {
        let api = routes.grouped("api")
        api.get("users", use: getUsers_v2)
        api.post("users", use: create)
    }
    
    func getUsers(req: Request) throws -> Response {
        let users = [
            ["name": 2],
            ["name": 3],
            ["name": "Alex"],
            ["name": "Alex"],
        ]
        let usersToData = try JSONSerialization.data(withJSONObject: users, options: .prettyPrinted)
        
        return Response(status: .ok, body: Response.Body(data: usersToData))
    }
    
    func getUsers_v2(req: Request) throws -> [User] {
        let users = [
            User(name: "Andres", age: 10, address: Address(street: "01823018", state: "CUN")),
            User(name: "Jonathand", age: 10)
        ]
        
        return users
    }
    
    func create(req: Request) throws -> HTTPStatus {
        let user = try req.content.decode(User.self)
        print(user)
        return .ok
    }
}

struct User: Content {
    let name: String
    let age: Int
    var address: Address? = nil
}

struct Address: Content {
    let street: String
    let state: String
}
