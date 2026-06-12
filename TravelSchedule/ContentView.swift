import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
	var body: some View {
		VStack {
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundStyle(.tint)
			Text("Hello, world!")
		}
		.padding()
		.onAppear {
			// Вызываем комплексную тестовую функцию вместо старой
			testAllServices()
		}
	}
	
	
	func testAllServices() {
			Task {
				do {
					let client = Client(
						serverURL: try Servers.Server1.url(),
						transport: URLSessionTransport()
					)
					let myKey = "bd6d6796-6978-4ecf-8211-11bd7d8fa3ca"
					
					print("🛸 НАЧАЛО КОМПЛЕКСНОГО ТЕСТИРОВАНИЯ API...")
					
					// 1. Тест сервиса ближайших станций
					let stationService = NearestStationsService(client: client, apikey: myKey)
					print("1️⃣ Запрос ближайших станций...")

					// ИСПРАВЛЕНО: Добавили print, чтобы использовать переменную stations
					let stations = try await stationService.getNearestStations(
						lat: 59.864177,
						lng: 30.319163,
						distance: 50
					)
					print("✅ Ближайшие станции успешно получены! Всего объектов: \(stations.stations?.count ?? 0)")
					
					// 2. Тест сервиса поиска рейсов (из Москвы c213 в Питер c2)
					let searchService = RouteSearchService(client: client, apikey: myKey)
					print("2️⃣ Запрос расписания рейсов...")
					let routes = try await searchService.fetchRoutes(
						from: "c213",
						to: "c2",
						date: "2026-07-15"
					)
					print("✅ Найдено сегментов маршрута: \(routes.segments?.count ?? 0)")
					
					// 3. Тест сервиса информации о перевозчике (Код 680 — РЖД)
					let carrierService = CarrierInfoService(client: client, apikey: myKey)
					print("3️⃣ Запрос информации о перевозчике...")
					let carrierData = try await carrierService.fetchCarrierInfo(code: "680")
					print("✅ Название компании из API: \(carrierData.carrier?.title ?? "Нет данных")")
					
					print("🎉 ВСЕ ТЕСТЫ УСПЕШНО ПРОЙДЕНЫ!")
					
				} catch {
					print("❌ Ошибка выполнения тестов: \(error)")
				}
			}
		}
	}

	#Preview {
		ContentView()
	}
