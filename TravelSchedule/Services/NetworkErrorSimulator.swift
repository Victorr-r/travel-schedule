import Foundation
import Combine

final class NetworkErrorSimulator: ObservableObject {
	@Published var activeError: ErrorType?
	
	enum ErrorType {
		case server
		case noInternet
	}
	
	init() {}
}
