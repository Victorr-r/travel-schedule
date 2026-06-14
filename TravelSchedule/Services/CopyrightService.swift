import Foundation
import OpenAPIRuntime

final class CopyrightService: BaseYandexService {
	
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
			throw APIError.invalidResponse
		}
	}
}
