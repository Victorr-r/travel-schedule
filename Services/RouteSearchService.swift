import Foundation
import OpenAPIRuntime

final class RouteSearchService {
	private let client: Client
	private let apikey: String
	
	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
	
	func fetchRoutes(from stationA: String, to stationB: String, date: String?) async throws -> Components.Schemas.Segments {
			
			let response = try await client.getSchedualBetweenStations(query: .init(
				apikey: apikey,
				from: stationA,
				to: stationB,
				date: date
			))
			
			switch response {
			case .ok(let successResponse):
				switch successResponse.body {
				case .json(let searchData):
					return searchData
				}
			default:
				throw NSError(
					domain: "RouteSearchService",
					code: 400,
					userInfo: [NSLocalizedDescriptionKey: "Неожиданный ответ сервера Яндекса"]
				)
			}
		}
}
