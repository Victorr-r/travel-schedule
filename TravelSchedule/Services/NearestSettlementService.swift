import Foundation
import OpenAPIRuntime

final class NearestSettlementService: BaseYandexService {
	
	func fetchNearestCity(lat: Double, lng: Double) async throws -> Components.Schemas.NearestCityResponse {
		let response = try await client.getNearestCity(query: .init(
			apikey: apikey,
			lat: lat,
			lng: lng
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .json(let cityData):
				return cityData
			}
		default:
			throw NSError(domain: "NearestSettlementService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Ошибка определения ближайшего города"])
		}
	}
}
