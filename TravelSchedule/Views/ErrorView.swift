import SwiftUI

struct ErrorView: View {
	let imageName: String
	let title: String
	
	var body: some View {
		ZStack {
			Color("YP White")
				.ignoresSafeArea()
			
			VStack(spacing: 16) {
				Image(imageName)
					.resizable()
					.scaledToFit()
					.frame(width: 223, height: 223)
				
				Text(title)
					.font(.system(size: 24, weight: .bold))
					.foregroundColor(Color("YP Black"))
					.multilineTextAlignment(.center)
					.padding(.horizontal, 16)
			}
		}
	}
}

#Preview("Ошибка сервера") {
	ErrorView(imageName: "ilServer Error", title: "Ошибка сервера")
}

#Preview("Нет интернета") {
	ErrorView(imageName: "ilNo Internet", title: "Нет интернета")
}
