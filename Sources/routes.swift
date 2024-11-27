import Foundation
import Vapor

func ConfigureRoutes(app: Application) {
    
    app.post("") { req in
        print("request at /")
        return Response(status: .ok, body: "Hello World")
    }
}
