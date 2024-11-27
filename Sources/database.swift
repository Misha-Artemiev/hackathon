import Fluent
import FluentPostgresDriver
import Vapor

func ConfigureConnection(_ app: Application) {
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: "localhost",
                port: 5440,
                username: "hackathonconnect",
                password: "vRexyDivQ5040MS",
                database: "hackathon",
                tls: .disable
            )
        ),
        as: .psql
    )
    
    app.migrations.add([CreateUsersTable()])
}

struct CreateUsersTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("username", .string)
            .field("password", .string)
            .field("created", .datetime)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}

final class User: Model, Content, @unchecked Sendable {
    
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    @Timestamp(key: "created", on: .create)
    var created: Date?
    
    init() {}
    
    init(id: UUID? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
