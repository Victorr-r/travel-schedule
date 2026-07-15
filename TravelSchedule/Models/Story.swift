import SwiftUI

struct Story: Identifiable, Hashable {
	let id = UUID()
	let previewImage: String
	let backgroundColor: Color
	let title: String
	let description: String
	var isWatched: Bool
}

extension Story {
	static let allStories: [Story] = [
		Story(
			previewImage: "Stories1",
			backgroundColor: Color(red: 232.0/255.0, green: 232.0/255.0, blue: 255.0/255.0),
			title: "🚂 Экспрессы",
			description: "Запускаем новые скоростные поезда между Москвой и Санкт-Петербургом со следующей недели.",
			isWatched: false
		),
		Story(
			previewImage: "Stories2",
			backgroundColor: Color.purple.opacity(0.8),
			title: "🎫 Кешбэк 10%",
			description: "Покупайте билеты через приложение и получайте повышенный кешбэк на поездки по выходным.",
			isWatched: false
		),
		Story(
			previewImage: "Stories3",
			backgroundColor: Color.orange.opacity(0.8),
			title: "⚠️ Изменения",
			description: "Обратите внимание на обновление расписания пригородных электричек Ярославского направления.",
			isWatched: false
		),
		Story(
			previewImage: "Stories4",
			backgroundColor: Color.teal.opacity(0.8),
			title: "🌍 Новые города",
			description: "Теперь в поиске доступны автобусные маршруты по всей Ленинградской и Московской областям.",
			isWatched: false
		)
	]
}
