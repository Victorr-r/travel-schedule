// 1. Импортируем библиотеки:
import OpenAPIRuntime
import OpenAPIURLSession

// 2. Улучшаем читаемость кода — необязательный шаг
// Создаём псевдоним (typealias) для сгенерированного типа Stations.
// Полное имя Components.Schemas.Stations соответствует пути в openapi.yaml:
// components → schemas → Stations
typealias NearestStations = Components.Schemas.Stations

// Определяем протокол для нашего сервиса (хорошая практика для тестирования и гибкости)
protocol NearestStationsServiceProtocol {
  // Функция для получения станций, асинхронная и может выбросить ошибку
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

// Конкретная реализация сервиса
final class NearestStationsService: NearestStationsServiceProtocol {
  // Хранит экземпляр сгенерированного клиента
  private let client: Client
  // Хранит API-ключ (лучше передавать его извне, чем хранить прямо в сервисе)
  private let apikey: String
  
  init(client: Client, apikey: String) {
	self.client = client
	self.apikey = apikey
  }
  
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
	let response = try await client.getNearestStations(query: .init(
		apikey: apikey,
		lat: lat,
		lng: lng,
		distance: distance
	))
	
	  
	return try response.ok.body.json
  }
}
