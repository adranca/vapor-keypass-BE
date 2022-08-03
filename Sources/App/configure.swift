import Vapor
import NIOSSL

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    try app.http.server.configuration.tlsConfiguration = .makeServerConfiguration(
        certificateChain: NIOSSLCertificate.fromPEMFile("/Users/alexandru.dranca/.localhost-ssl/localhost.crt").map { .certificate($0)
        },
        privateKey: .privateKey(.init(file: "/Users/alexandru.dranca/.localhost-ssl/localhost.key", format: .pem))
    )
    
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
}
