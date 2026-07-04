import Foundation
import OpenAPIRuntime

final class CarrierInfoService: BaseYandexService {
	
	func fetchCarrierInfo(code: String) async throws -> Components.Schemas.CarrierResponse {
		let response = try await client.getCarrierInfo(query: .init(
			apikey: apikey,
			code: code
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .json(let carrierData):
				return carrierData
			}
		case .undocumented(statusCode: _, _):
			throw APIError.invalidResponse
		}
	}
}
