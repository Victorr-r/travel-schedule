import Foundation
import OpenAPIRuntime

final class CopyrightService {
	private let client: Client
	private let apikey: String
	
	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
	
	func fetchCopyright() async throws -> Components.Schemas.CopyrightResponse {
		let response = try await client.getCopyrightInfo(query: .init(
			apikey: apikey,
			format: "json"
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .json(let copyrightData):
				return copyrightData
			}
		default:
			throw NSError(domain: "CopyrightService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Ошибка получения копирайта"])
		}
	}
}
