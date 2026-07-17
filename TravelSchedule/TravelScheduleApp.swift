import SwiftUI

@main
struct TravelScheduleApp: App {
	@AppStorage(StorageKeys.isDarkMode) private var isDarkMode = false
	@State private var isSplashActive = true
	
	var body: some Scene {
		WindowGroup {
			ZStack {
				if isSplashActive {
					SplashScreenView()
						.transition(.opacity)
				} else {
					ContentView()
						.transition(.opacity)
				}
			}
			.preferredColorScheme(isDarkMode ? .dark : .light)
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
					withAnimation(.easeInOut(duration: 0.5)) {
						isSplashActive = false
					}
				}
			}
		}
	}
}
