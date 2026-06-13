import Foundation
import OpenAPIRuntime

final class ThreadRouteService {
	private let client: Client
	private let apikey: String
	
	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
	
	func fetchThreadRoute(threadUID: String) async throws -> Components.Schemas.ThreadStationsResponse {
		let response = try await client.getRouteStations(query: .init(
			apikey: apikey,
			uid: threadUID
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .json(let threadData):
				return threadData
			}
		default:
			throw NSError(domain: "ThreadRouteService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Ошибка получения станций нитки"])
		}
	}
}
