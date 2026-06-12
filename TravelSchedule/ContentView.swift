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
			// testAllServices()
		}
	}
}

#Preview {
	ContentView()
}

/*
func testAllServices() {
	Task {
		do {
			let client = Client(
				serverURL: try Servers.server1(),
				transport: URLSessionTransport()
			)
			let myKey = "bd6d6796-6978-4ecf-8211-11bd7d8fa3ca"
			
			print("🛸 НАЧАЛО КОМПЛЕКСНОГО ТЕСТИРОВАНИЯ API...")
			
			
			let stationService = NearestStationsService(client: client, apikey: myKey)
			print("1️⃣ Запрос ближайших станций...")
			let stations = try await stationService.getNearestStations(
				lat: 59.864177,
				lng: 30.319163,
				distance: 50
			)
			print("✅ Ближайшие станции успешно получены! Всего объектов: \(stations.stations?.count ?? 0)")
			
			
			let response = try await client.getSchedualBetweenStations(query: .init(
				apikey: myKey,
				from: "c213",
				to: "c2",
				date: "2026-07-15"
			))
			
			switch response {
			case .ok(let successResponse):
				switch successResponse.body {
				case .json(let searchData):
					print("✅ Найдено сегментов маршрута: \(searchData.segments?.count ?? 0)")
				}
			default:
				print("⚠️ Неожиданный ответ по рейсам")
			}
			
			
			let carrierService = CarrierInfoService(client: client, apikey: myKey)
			print("3️⃣ Запрос информации о перевозчике...")
			let carrierData = try await carrierService.fetchCarrierInfo(code: "680")
			print("✅ Название компании из API: \(carrierData.carriers?.first?.title ?? "Нет данных")")
			
			print("🎉 ВСЕ ТЕСТЫ УСПЕШНО ПРОЙДЕНЫ!")
			
		} catch {
			print("❌ Ошибка выполнения тестов: \(error)")
		}
	}
}*/
