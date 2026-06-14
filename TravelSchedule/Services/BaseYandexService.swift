import Foundation

class BaseYandexService {
	let client: Client
	let apikey: String

	init(client: Client, apikey: String) {
		self.client = client
		self.apikey = apikey
	}
}
