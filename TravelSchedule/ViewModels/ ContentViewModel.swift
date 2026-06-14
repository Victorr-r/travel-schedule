import Foundation
import Observation
import OpenAPIRuntime
import OpenAPIURLSession

@Observable
@MainActor
final class ContentViewModel {
	
	var isDiagnosticComplete = false
	var statusMessage = "Ожидание запуска тестов API..."
	
	func runYandexServicesDiagnostic() async {
		statusMessage = "🚀 Запуск диагностики всех сервисов Яндекса..."
		
		do {
			let client = Client(serverURL: try Servers.Server1.url(), transport: URLSessionTransport())
			let myKey = ProcessInfo.processInfo.environment["YANDEX_API_KEY"] ?? ""
			
			print("🚀 ЗАПУСК ДИАГНОСТИКИ ВСЕХ СЕРВИСОВ ЯНДЕКСА...")
			print("--------------------------------------------------")
			
			let copyrightService = CopyrightService(client: client, apikey: myKey)
			let copyrightData = try await copyrightService.fetchCopyright()
			print("ℹ️ [1/8] Копирайт: \(copyrightData.copyright?.text ?? "Нет данных")")
			
			let stationService = NearestStationsService(client: client, apikey: myKey)
			let stations = try await stationService.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
			print("ℹ️ [2/8] Ближайшие станции: Найдено \(stations.stations?.count ?? 0) вокзалов/остановок")
			
			let searchService = RouteSearchService(client: client, apikey: myKey)
			let routes = try await searchService.fetchRoutes(from: "c213", to: "c2", date: "2026-07-15")
			print("ℹ️ [3/8] Рейсы между станциями: Доступно \(routes.segments?.count ?? 0) сегментов маршрута")
			
			let stationScheduleService = StationScheduleService(client: client, apikey: myKey)
			let schedule = try await stationScheduleService.fetchStationSchedule(stationCode: "s9601666", date: "2026-07-15")
			print("ℹ️ [4/8] Расписание по вокзалу: Получено \(schedule.schedule?.count ?? 0) прибывающих/убывающих поездов")
			
			let threadRouteService = ThreadRouteService(client: client, apikey: myKey)
			if let firstRouteUid = routes.segments?.first?.thread?.uid {
				let threadData = try await threadRouteService.fetchThreadRoute(threadUID: firstRouteUid)
				print("ℹ️ [5/8] Станции следования поезда: Найдено \(threadData.stops?.count ?? 0) промежуточных остановок")
			} else {
				print("ℹ️ [5/8] Станции следования поезда: Пропущено (требуется active UID рейса)")
			}
			
			let nearestSettlementService = NearestSettlementService(client: client, apikey: myKey)
			let cityData = try await nearestSettlementService.fetchNearestCity(lat: 55.755826, lng: 37.617299)
			print("ℹ️ [6/8] Ближайший город по GPS: Вы находитесь в населенном пункте — \(cityData.title ?? "Не определен")")
			
			let carrierService = CarrierInfoService(client: client, apikey: myKey)
			let carrierData = try await carrierService.fetchCarrierInfo(code: "680")
			print("ℹ️ [7/8] Информация о перевозчике: Название компании из API — \(carrierData.carriers?.first?.title ?? "Нет данных")")
			
			let allStationsService = AllStationsListService(client: client, apikey: myKey)
			_ = try await allStationsService.fetchAllStations()
			print("ℹ️ [8/8] Глобальный список всех станций Яндекса: Архив успешно запрошен в фоне")
			
			print("--------------------------------------------------")
			print("🎉 ДИАГНОСТИКА УСПЕШНО ЗАВЕРШЕНА! Все сервисы работают идеально.")
			
			statusMessage = "Приложение готово к работе"
			isDiagnosticComplete = true
			
		} catch {
			print("❌ ОШИБКА ОДНОГО ИЗ СЕРВИСОВ: \(error.localizedDescription)")
			statusMessage = "Ошибка сети: \(error.localizedDescription)"
		}
	}
}
