import Foundation
import OpenAPIRuntime

final class AllStationsListService: BaseYandexService {
	
	func fetchAllStations() async throws -> Components.Schemas.AllStationsResponse {
		let response = try await client.getAllStations(query: .init(
			apikey: apikey
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .html(let htmlBody):
				let limit = 50 * 1024 * 1024
				let fullData = try await Data(collecting: htmlBody, upTo: limit)
				
				let allStations = try JSONDecoder().decode(
					Components.Schemas.AllStationsResponse.self,
					from: fullData
				)
				return allStations
			}
			
		default:
			throw NSError(
				domain: "AllStationsListService",
				code: 400,
				userInfo: [NSLocalizedDescriptionKey: "Ошибка скачивания базы станций Яндекса"]
			)
		}
	}
}
