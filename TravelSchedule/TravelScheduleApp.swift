import SwiftUI

@main
struct TravelScheduleApp: App {
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
