//
//  UserController.swift
//  
//
//  Created by Eduardo Andres Rodriguez Parejo on 10/13/21.
//

import Foundation
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        // /users
        let users = routes.grouped("users")
        
        // GET /users
        users.get(use: index)
        
        // POST /users
        users.post(use: create)
        
        users.group(":userId") { user in
            // GET /users/:id
            user.get(use: show)
        }
    }
    
    func show(req: Request) throws -> String {
        guard let userId = req.parameters.get("userId") else {
            throw Abort(.badRequest)
        }
        
        return userId
    }
    // /users
    func index(req: Request) throws -> String {
        return "INDEX"
    }
    
    func create(req: Request) throws -> String {
        return "create"
    }
}
