import SwiftUI

struct SplashScreenView: View {
	var body: some View {
		ZStack {
			Image("Splash Screen")
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}


#Preview {
	SplashScreenView()
}
