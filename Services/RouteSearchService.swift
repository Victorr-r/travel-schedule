import Foundation
import OpenAPIRuntime

final class RouteSearchService {
	private let client: Client
	private let apikey: String
	
	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
	
	/// Запрашивает список рейсов между станциями
	func fetchRoutes(from stationA: String, to stationB: String, date: String?) async throws -> Components.Schemas.SearchResponse {
		// Вызываем метод, сгенерированный из operationId: searchRoutes
		let response = try await client.searchRoutes(query: .init(
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
		case .undocumented(statusCode: let code, _):
			throw NSError(domain: "RouteSearchService", code: code, userInfo: [NSLocalizedDescriptionKey: "Неожиданный ответ сервера: \(code)"])
		}
	}
}
