import SwiftUI

struct SettingsView: View {
	@AppStorage("isDarkMode") private var isDarkMode = false
	@State private var showUserAgreement = false
	@State private var showDebugMenu = false
	@ObservedObject var errorSimulator: NetworkErrorSimulator
	
	var body: some View {
		ZStack {
			Color(.ypWhite)
				.ignoresSafeArea()
			
			VStack(spacing: 0) {
				HStack {
					Spacer()
					Button(action: {
						showDebugMenu = true
					}) {
						Image(systemName: "ladybug.fill")
							.font(.system(size: 17, weight: .semibold))
							.foregroundColor(Color(.ypBlue))
					}
					.padding(.horizontal, 16)
					.frame(height: 44)
				}
				
				VStack(spacing: 0) {
					Toggle(isOn: $isDarkMode) {
						Text("Тёмная тема")
							.font(.system(size: 17, weight: .regular))
							.foregroundColor(Color(.ypBlack))
					}
					.tint(Color(.ypBlue))
					.frame(height: 60)
					.padding(.horizontal, 16)
					
					Button(action: {
						showUserAgreement = true
					}) {
						HStack {
							Text("Пользовательское соглашение")
								.font(.system(size: 17, weight: .regular))
								.foregroundColor(Color(.ypBlack))
							Spacer()
							Image(systemName: "chevron.right")
								.font(.system(size: 17, weight: .bold))
								.foregroundColor(Color(.ypBlack))
						}
						.frame(height: 60)
						.padding(.horizontal, 16)
					}
				}
				.padding(.top, 4)
				
				Spacer()
				
				VStack(spacing: 12) {
					Text("Приложение использует API «Яндекс.Расписания»")
						.font(.system(size: 12, weight: .regular))
						.foregroundColor(Color(.ypBlack))
						.multilineTextAlignment(.center)
					
					Text("Версия 1.0 (beta)")
						.font(.system(size: 12, weight: .regular))
						.foregroundColor(Color(.ypBlack))
				}
				.padding(.horizontal, 16)
				.padding(.bottom, 24)
			}
		}
		.fullScreenCover(isPresented: $showUserAgreement) {
			UserAgreementView()
		}
		.sheet(isPresented: $showDebugMenu) {
			DebugNetworkView(errorSimulator: errorSimulator)
		}
	}
}

struct DebugNetworkView: View {
	@AppStorage("isDarkMode") private var isDarkMode = false
	@ObservedObject var errorSimulator: NetworkErrorSimulator
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		ZStack {
			Color(.ypWhite)
				.ignoresSafeArea()
			
			VStack(spacing: 24) {
				HStack {
					Spacer()
					Button("Готово") {
						dismiss()
					}
					.font(.system(size: 17, weight: .bold))
					.foregroundColor(Color(.ypBlue))
				}
				.padding([.top, .horizontal], 16)
				
				Text("Настройки симуляции сети")
					.font(.system(size: 20, weight: .bold))
					.foregroundColor(Color(.ypBlack))
				
				Button(action: { errorSimulator.activeError = nil }) {
					Text("Всё ок (Сеть работает)")
						.font(.system(size: 17, weight: .semibold))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.frame(height: 50)
						.background(errorSimulator.activeError == nil ? Color(.ypBlue) : Color.gray)
						.cornerRadius(12)
				}
				
				Button(action: { errorSimulator.activeError = .server }) {
					Text("Симулировать: Ошибка сервера")
						.font(.system(size: 17, weight: .semibold))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.frame(height: 50)
						.background(errorSimulator.activeError == .server ? Color.red : Color.gray)
						.cornerRadius(12)
				}
				
				Button(action: { errorSimulator.activeError = .noInternet }) {
					Text("Симулировать: Нет интернета")
						.font(.system(size: 17, weight: .semibold))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.frame(height: 50)
						.background(errorSimulator.activeError == .noInternet ? Color.red : Color.gray)
						.cornerRadius(12)
				}
				Spacer()
			}
			.padding(.horizontal, 16)
		}
		.preferredColorScheme(isDarkMode ? .dark : .light)
	}
}

#Preview {
	SettingsView(errorSimulator: NetworkErrorSimulator())
}
