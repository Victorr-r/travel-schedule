import Foundation

enum APIError: Error, LocalizedError {
	case invalidResponse
	case invalidURL
	case decodingError
	case serverError(Int)
	case unknown
	
	var errorDescription: String? {
		switch self {
		case .invalidResponse:
			return "Некорректный ответ от сервера Яндекса."
		case .invalidURL:
			return "Неверный формат адреса запроса."
		case .decodingError:
			return "Ошибка декодирования данных."
		case .serverError(let code):
			return "Ошибка сервера Яндекса. Код ответа: \(code)."
		case .unknown:
			return "Произошла неизвестная ошибка сети."
		}
	}
}
