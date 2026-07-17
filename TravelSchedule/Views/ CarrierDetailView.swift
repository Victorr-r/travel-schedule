import SwiftUI

struct CarrierDetailView: View {
	let carrier: CarrierInfo
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		ZStack {
			Color(.ypWhite)
				.ignoresSafeArea()
			
			VStack(spacing: 0) {
				HStack {
					Button(action: { dismiss() }) {
						Image(systemName: SFSymbols.chevronLeft)
							.font(.system(size: 17, weight: .bold))
							.foregroundStyle(Color(.ypBlack))
					}
					Spacer()
					Text("Информация о перевозчике")
						.font(.system(size: 17, weight: .bold))
						.foregroundStyle(Color(.ypBlack))
					Spacer()
					Image(systemName: SFSymbols.chevronLeft)
						.font(.system(size: 17, weight: .bold))
						.foregroundColor(.clear)
				}
				.padding(.horizontal, 16)
				.frame(height: 44)
				
				ScrollView(.vertical) {
					VStack(spacing: 0) {
						Image("РЖД инфо")
							.resizable()
							.scaledToFill()
							.frame(maxWidth: .infinity)
							.frame(height: 104)
							.background(Color.white)
							.clipShape(RoundedRectangle(cornerRadius: 24))
							.padding(.horizontal, 16)
							.padding(.top, 16)
						
						HStack {
							Text("ОАО «\(carrier.title)»")
								.font(.system(size: 24, weight: .bold))
								.foregroundStyle(Color(.ypBlack))
							Spacer()
						}
						.padding(.top, 16)
						.padding(.horizontal, 16)
						
						VStack(alignment: .leading, spacing: 0) {
							VStack(alignment: .leading, spacing: 4) {
								Text("E-mail")
									.font(.system(size: 17, weight: .regular))
									.foregroundStyle(Color(.ypBlack))
									.frame(height: 22)
								
								Text(verbatim: "i.lobanov@yandex.ru")
									.font(.system(size: 12, weight: .regular))
									.foregroundStyle(Color(.ypBlue))
							}
							.padding(.horizontal, 16)
							.frame(maxWidth: .infinity, alignment: .leading)
							.frame(height: 60)
							
							VStack(alignment: .leading, spacing: 4) {
								Text("Telephone")
									.font(.system(size: 17, weight: .regular))
									.foregroundStyle(Color(.ypBlack))
									.frame(height: 22)
								
								Text("+7 (912) 345-67-89")
									.font(.system(size: 12, weight: .regular))
									.foregroundStyle(Color(.ypBlue))
							}
							.padding(.horizontal, 16)
							.frame(maxWidth: .infinity, alignment: .leading)
							.frame(height: 60)
						}
						.padding(.top, 16)
					}
				}
				.scrollIndicators(.hidden)
			}
		}
		.navigationBarHidden(true)
	}
}
