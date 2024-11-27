import Foundation
import Vapor

func ConfigureRoutes(app: Application) {
    
    app.post("register") { req in
        return try await RegisterRequest(req: req)
    }
    
    app.post("login") { req in
        print("request at /")
        return Response(status: .ok, body: "Hello World")
    }
    
    app.post("record") { req in
        print("request at /")
        return Response(status: .ok, body: "Hello World")
    }
    
    app.post("get") { req in
        print("request at /")
        return Response(status: .ok, body: "Hello World")
    }
}
