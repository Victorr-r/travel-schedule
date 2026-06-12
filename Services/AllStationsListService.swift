import Foundation
import OpenAPIRuntime

final class AllStationsListService {
	private let client: Client
	private let apikey: String
	
	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
	
	func fetchAllStations() async throws {
		let response = try await client.getAllStations(query: .init(
			apikey: apikey
		))
		
		switch response {
				case .ok:
					print("✅ База данных всех станций успешно скачана с сервера Яндекса")
					
				default:
					throw NSError(
						domain: "AllStationsListService",
						code: 400,
						userInfo: [NSLocalizedDescriptionKey: "Ошибка скачивания базы станций Яндекса"]
					)
				}
	}
}
