import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
	func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService:BaseYandexService, NearestStationsServiceProtocol {
	
	func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
		let response = try await client.getNearestStations(query: .init(
			apikey: apikey,
			lat: lat,
			lng: lng,
			distance: distance
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .json(let stationsData):
				return stationsData
			}
		default:
			throw APIError.invalidResponse
		}
	}
}
