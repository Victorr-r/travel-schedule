import Foundation
import Combine

final class NetworkErrorSimulator: ObservableObject {
	static let shared = NetworkErrorSimulator()
	
	@Published var activeError: ErrorType? = nil
	
	enum ErrorType {
		case server
		case noInternet
	}
	
	private init() {}
}
