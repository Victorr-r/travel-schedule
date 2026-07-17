import SwiftUI

struct Story: Identifiable, Hashable {
	let id = UUID()
	let previewImageName: String
	let backgroundColor: Color
	let title: String
	let description: String
	var isWatched: Bool
}

extension Story {
	static let allStories: [Story] = [
		Story(
			previewImageName: "Stories1",
			backgroundColor: Color(red: 232.0/255.0, green: 232.0/255.0, blue: 255.0/255.0),
			title: "🚂 Экспрессы",
			description: "Новые скоростные поезда между Москвой и Питером со следующей недели.",
			isWatched: false
		),
		Story(
			previewImageName: "Stories2",
			backgroundColor: Color.purple.opacity(0.8),
			title: "🎫 Кешбэк 10%",
			description: "Покупайте билеты в приложении и получайте кешбэк на поездки.",
			isWatched: false
		),
		Story(
			previewImageName: "Stories3",
			backgroundColor: Color.orange.opacity(0.8),
			title: "⚠️ Расписание",
			description: "Обновление графика электричек на Ярославском направлении.",
			isWatched: false
		),
		Story(
			previewImageName: "Stories4",
			backgroundColor: Color.teal.opacity(0.8),
			title: "🌍 Новые города",
			description: "В поиске стали доступны автобусные маршруты по всей области.",
			isWatched: false
		)
	]
}
