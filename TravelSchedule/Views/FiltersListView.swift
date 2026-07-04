import SwiftUI

struct FiltersListView: View {
	@Environment(\.dismiss) private var dismiss
	
	@State private var morningTime = false
	@State private var afternoonTime = false
	@State private var eveningTime = false
	@State private var nightTime = false
	
	@State private var allowTransfers = false
	@State private var noTransfers = false
	
	var body: some View {
		ZStack(alignment: .bottom) {
			Color(.ypWhite)
				.ignoresSafeArea()
			
			VStack(spacing: 0) {
				VStack(spacing: 0) {
					HStack(spacing: 0) {
						Button(action: { dismiss() }) {
							Image(systemName: "chevron.left")
								.font(.system(size: 17, weight: .bold))
								.foregroundColor(Color(.ypBlack))
						}
						Spacer()
					}
					.padding(.horizontal, 16)
					.padding(.top, 11)
					.frame(height: 44)
				}
				
				ScrollView(.vertical, showsIndicators: false) {
					VStack(alignment: .leading, spacing: 0) {
						Text("Время отправления")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color(.ypBlack))
							.padding(.horizontal, 16)
							.padding(.top, 16)
							.padding(.bottom, 8)
						
						filterRow(title: "Утро 06:00 - 12:00", isSelected: $morningTime, isCheckbox: true)
						filterRow(title: "День 12:00 - 18:00", isSelected: $afternoonTime, isCheckbox: true)
						filterRow(title: "Вечер 18:00 - 00:00", isSelected: $eveningTime, isCheckbox: true)
						filterRow(title: "Ночь 00:00 - 06:00", isSelected: $nightTime, isCheckbox: true)
						
						Text("Показывать варианты с пересадками")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color(.ypBlack))
							.padding(.horizontal, 16)
							.padding(.top, 24)
							.padding(.bottom, 8)
						
						filterRow(title: "Да", isSelected: $allowTransfers, isCheckbox: false)
						filterRow(title: "Нет", isSelected: $noTransfers, isCheckbox: false)
					}
					.padding(.bottom, 140)
				}
			}
			
			if morningTime || afternoonTime || eveningTime || nightTime || allowTransfers || noTransfers {
				Button(action: {
					dismiss()
				}) {
					Text("Применить")
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.frame(height: 60)
						.background(Color(.ypBlue))
						.cornerRadius(16)
				}
				.padding(.horizontal, 16)
				.padding(.bottom, 58)
			}
		}
		.navigationBarHidden(true)
	}
	
	@ViewBuilder
	private func filterRow(title: String, isSelected: Binding<Bool>, isCheckbox: Bool) -> some View {
		Button(action: {
			if !isCheckbox {
				if title == "Да" {
					allowTransfers = true
					noTransfers = false
				} else {
					allowTransfers = false
					noTransfers = true
				}
			} else {
				isSelected.wrappedValue.toggle()
			}
		}) {
			HStack(spacing: 0) {
				Text(title)
					.font(.system(size: 17, weight: .regular))
					.foregroundColor(Color(.ypBlack))
				
				Spacer()
				
				if isCheckbox {
					Image(systemName: isSelected.wrappedValue ? "checkmark.square.fill" : "square")
						.font(.system(size: 22))
						.foregroundColor(Color(.ypBlack))
				} else {
					Image(systemName: isSelected.wrappedValue ? "largecircle.fill.circle" : "circle")
						.font(.system(size: 22))
						.foregroundColor(Color(.ypBlack))
				}
			}
			.padding(.horizontal, 16)
			.frame(maxWidth: .infinity)
			.frame(height: 60)
			.background(Color(.ypWhite))
		}
	}
}

#Preview {
	FiltersListView()
}
