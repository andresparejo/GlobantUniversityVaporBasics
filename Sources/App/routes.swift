import Vapor


func routes(_ app: Application) throws {
    // localhost:8080/
    app.get { req in
        return "ROOT"
    }

    // localhost:8080/hello
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
//    //localhost:8080/movies/genre/comedy
//    app.get("movies", "genre", "comedy") {req in
//        return "localhost:8080/movies/genre/comedy"
//    }
    
    //localhost:8080/movies/genre/<your genre>
    app.get("movies", "genre", ":name") { req -> String in
        guard let name = req.parameters.get("name") else {
            throw Abort(.badRequest)
        }
        
        return "The genre war \(name)"
    }
    
    //localhost:8080/movies/genre/<your genre>/year/<your year>
    app.get("movies", "genre", ":name", "year", ":year") { req -> String in
        guard
            let name = req.parameters.get("name"),
            let year = req.parameters.get("year")
        else {
            throw Abort(.badRequest)
        }
        
        return "The genre war \(name) and year \(year)"
    }
    
    //localhost:8080/movies/<your type>/<your genre>
    app.get("movies", "*", ":name") { req -> String in
        return "FOO"
    }
    
    app.get("movies", "**") { req -> String in
        return "BAZZ"
    }
    
    ///QUERY:
    ///localhost:8080/search?keyword=toy&page=12
    app.get("search") { req -> String in
        guard
            let keyword = try? req.query.get(String.self, at: "keyword"),
            let page = try? req.query.get(Int.self, at: "page")
        else {
            throw Abort(.badRequest)
        }
        
        return "keyword = \(keyword), page = \(page)"
    }
    
    try app.register(collection: UserController())
    try app.register(collection: ApiController())
}
