import SwiftUI

struct Story: Identifiable, Hashable {
	let id: UUID
	let previewImageName: String
	let backgroundColor: Color
	let title: String
	let description: String
	let isWatched: Bool

	init(
		id: UUID = UUID(),
		previewImageName: String,
		backgroundColor: Color,
		title: String,
		description: String,
		isWatched: Bool = false
	) {
		self.id = id
		self.previewImageName = previewImageName
		self.backgroundColor = backgroundColor
		self.title = title
		self.description = description
		self.isWatched = isWatched
	}

	func with(isWatched: Bool) -> Story {
		Story(
			id: self.id,
			previewImageName: self.previewImageName,
			backgroundColor: self.backgroundColor,
			title: self.title,
			description: self.description,
			isWatched: isWatched
		)
	}
}

extension Story {
	static let allStories: [Story] = [
		Story(
			previewImageName: "Stories1",
			backgroundColor: Color(red: 232.0/255.0, green: 232.0/255.0, blue: 255.0/255.0),
			title: "🚂 Экспрессы",
			description: "Новые скоростные поезда между Москвой и Питером со следующей недели."
		),
		Story(
			previewImageName: "Stories2",
			backgroundColor: Color.purple.opacity(0.8),
			title: "🎫 Кешбэк 10%",
			description: "Покупайте билеты в приложении и получайте кешбэк на поездки."
		),
		Story(
			previewImageName: "Stories3",
			backgroundColor: Color.orange.opacity(0.8),
			title: "⚠️ Расписание",
			description: "Обновление графика электричек на Ярославском направлении."
		),
		Story(
			previewImageName: "Stories4",
			backgroundColor: Color.teal.opacity(0.8),
			title: "🌍 Новые города",
			description: "В поиске стали доступны автобусные маршруты по всей области."
		)
	]
}
