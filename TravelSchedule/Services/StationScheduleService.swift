import Foundation
import OpenAPIRuntime

final class StationScheduleService: BaseYandexService {
	
	func fetchStationSchedule(stationCode: String, date: String? = nil) async throws -> Components.Schemas.ScheduleResponse {
		
		let response = try await client.getStationSchedule(query: .init(
			apikey: apikey,
			station: stationCode,
			date: date
		))
		
		switch response {
		case .ok(let successResponse):
			switch successResponse.body {
			case .json(let scheduleData):
				return scheduleData
			}
		default:
			throw NSError(
				domain: "StationScheduleService",
				code: 400,
				userInfo: [NSLocalizedDescriptionKey: "Неожиданный ответ сервера Яндекса при запросе расписания по станции"]
			)
		}
	}
}
