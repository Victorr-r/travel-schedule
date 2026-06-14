import Foundation
import OpenAPIRuntime

final class RouteSearchService: BaseYandexService {
	
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
			throw APIError.invalidResponse
		}
	}
}
