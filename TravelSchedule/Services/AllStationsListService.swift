import Foundation
import OpenAPIRuntime

final class AllStationsListService: BaseYandexService {
	
	func fetchAllStations() async throws -> Components.Schemas.AllStationsResponse {
		let response = try await client.getAllStations(query: .init(
			apikey: apikey
		))
		
		switch response {
		case .ok(let successResponse):
			let mirror = Mirror(reflecting: successResponse.body)
			guard let associatedBody = mirror.children.first?.value as? HTTPBody else {
				throw NSError(
					domain: "AllStationsListService",
					code: 402,
					userInfo: [NSLocalizedDescriptionKey: "Не удалось извлечь поток данных ответа Яндекса"]
				)
			}
			
			let limit = 50 * 1024 * 1024
			let fullData = try await Data(collecting: associatedBody, upTo: limit)
			
			let allStations = try JSONDecoder().decode(
				Components.Schemas.AllStationsResponse.self,
				from: fullData
			)
			
			return allStations
			
		default:
			throw NSError(
				domain: "AllStationsListService",
				code: 400,
				userInfo: [NSLocalizedDescriptionKey: "Ошибка скачивания базы станций Яндекса"]
			)
		}
	}
}
