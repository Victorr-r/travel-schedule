import Foundation
import OpenAPIRuntime

final class CarrierInfoService {
	private let client: Client
	private let apikey: String
	
	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
	
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
		case .undocumented(statusCode: let code, _):
			throw NSError(domain: "CarrierInfoService", code: code, userInfo: [NSLocalizedDescriptionKey: "Неожиданный ответ сервера: \(code)"])
		}
	}
}
