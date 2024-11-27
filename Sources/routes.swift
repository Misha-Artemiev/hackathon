import Foundation
import Vapor

func ConfigureRoutes(app: Application) {
    
    app.post("") { req in
        return Response(status: .ok, body: "Hello World")
    }
}
