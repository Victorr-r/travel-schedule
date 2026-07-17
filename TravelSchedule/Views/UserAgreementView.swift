import SwiftUI

struct UserAgreementView: View {
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		ZStack {
			Color(.ypWhite)
				.ignoresSafeArea()
			
			VStack(spacing: 0) {
				HStack {
					Button(action: { dismiss() }) {
						Image(systemName: "chevron.left")
							.font(.system(size: 17, weight: .bold))
							.foregroundColor(Color(.ypBlack))
					}
					Spacer()
					Text("Пользовательское соглашение")
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(Color(.ypBlack))
					Spacer()
					Image(systemName: "chevron.left")
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(.clear)
				}
				.padding(.horizontal, 16)
				.frame(height: 44)
				
				ScrollView(.vertical, showsIndicators: false) {
					Image("Пол согл")
						.resizable()
						.scaledToFit()
						.frame(maxWidth: .infinity)
						.padding(.horizontal, 16)
						.padding(.top, 16)
				}
				.background(Color(.ypWhite))
			}
		}
	}
}

#Preview {
	UserAgreementView()
}
