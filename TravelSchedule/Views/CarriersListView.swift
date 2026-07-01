import SwiftUI

struct CarrierInfo: Identifiable {
	let id = UUID()
	let logoName: String
	let title: String
	let dateInfo: String
	let departureTime: String
	let arrivalTime: String
	let duration: String
	let transferInfo: String?
}

struct CarriersListView: View {
	@Environment(\.dismiss) private var dismiss
	var directionTitle: String
	@State private var showFilters = false
	
	let carriers = [
		CarrierInfo(logoName: "РЖД", title: "РЖД", dateInfo: "14 января", departureTime: "22:30", arrivalTime: "08:15", duration: "20 часов", transferInfo: "С пересадкой в Костроме"),
		CarrierInfo(logoName: "ФГК", title: "ФГК", dateInfo: "15 января", departureTime: "01:15", arrivalTime: "09:00", duration: "7 часов 45 мин", transferInfo: nil),
		CarrierInfo(logoName: "Урал логистика", title: "Урал логистика", dateInfo: "16 января", departureTime: "12:30", arrivalTime: "21:00", duration: "8 часов 30 мин", transferInfo: nil),
		CarrierInfo(logoName: "РЖД", title: "РЖД", dateInfo: "17 января", departureTime: "22:30", arrivalTime: "08:15", duration: "20 часов", transferInfo: "С пересадкой в Костроме")
	]
	
	var body: some View {
		ZStack(alignment: .bottom) {
			Color("YP White")
				.ignoresSafeArea()
			
			if carriers.isEmpty {
				VStack {
					Spacer()
					Text("Вариантов нет")
						.font(.system(size: 24, weight: .bold))
						.foregroundColor(Color("YP Black"))
					Spacer()
				}
			} else {
				VStack(spacing: 0) {
					VStack(spacing: 0) {
						HStack(spacing: 0) {
							Button(action: { dismiss() }) {
								Image(systemName: "chevron.left")
									.font(.system(size: 17, weight: .bold))
									.foregroundColor(Color("YP Black"))
							}
							Spacer()
						}
						.padding(.horizontal, 16)
						.padding(.top, 11)
						.frame(height: 44)
					}
					
					HStack(spacing: 0) {
						Text(directionTitle)
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color("YP Black"))
							.multilineTextAlignment(.leading)
							.lineLimit(3)
						Spacer()
					}
					.padding(.horizontal, 16)
					.padding(.top, 16)
					
					ScrollView(.vertical, showsIndicators: false) {
						LazyVStack(spacing: 8) {
							ForEach(carriers) { carrier in
								VStack(spacing: 0) {
									HStack(alignment: .top, spacing: 0) {
										HStack(spacing: 8) {
											Image(carrier.logoName)
												.resizable()
												.scaledToFill()
												.frame(width: 38, height: 38)
												.cornerRadius(12)
											
											VStack(alignment: .leading, spacing: 2) {
												Text(carrier.title)
													.font(.system(size: 17, weight: .regular))
													.foregroundColor(Color("YP Black"))
												
												if let transfer = carrier.transferInfo {
													Text(transfer)
														.font(.system(size: 12, weight: .regular))
														.foregroundColor(.red)
												}
											}
										}
										
										Spacer()
										
										Text(carrier.dateInfo)
											.font(.system(size: 12, weight: .regular))
											.foregroundColor(Color("YP Black"))
											.padding(.top, 2)
									}
									.padding(.top, 14)
									.padding(.horizontal, 14)
									
									Spacer(minLength: 0)
									
									HStack(spacing: 0) {
										Text(carrier.departureTime)
											.font(.system(size: 17, weight: .regular))
											.foregroundColor(Color("YP Black"))
										
										ZStack {
											Rectangle()
												.fill(Color("YP Black").opacity(0.15))
												.frame(height: 1)
											
											Text(carrier.duration)
												.font(.system(size: 12, weight: .regular))
												.foregroundColor(Color("YP Black"))
												.padding(.horizontal, 4)
												.background(Color(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0))
										}
										.padding(.horizontal, 4)
										
										Text(carrier.arrivalTime)
											.font(.system(size: 17, weight: .regular))
											.foregroundColor(Color("YP Black"))
									}
									.padding(.bottom, 14)
									.padding(.horizontal, 14)
								}
								.frame(maxWidth: .infinity)
								.frame(height: 104)
								.background(Color(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0))
								.cornerRadius(24)
								.environment(\.colorScheme, .light)
							}
						}
						.padding(.horizontal, 16)
						.padding(.top, 16)
						.padding(.bottom, 140)
					}
				}
			}
			
			Button(action: {
				showFilters = true
			}) {
				Text("Уточнить время")
					.font(.system(size: 17, weight: .bold))
					.foregroundColor(.white)
					.frame(maxWidth: .infinity)
					.frame(height: 60)
					.background(Color("YP Blue"))
					.cornerRadius(16)
			}
			.padding(.horizontal, 16)
			.padding(.bottom, 58)
		}
		.navigationBarHidden(true)
		.fullScreenCover(isPresented: $showFilters) {
			FiltersListView()
		}
	}
}

#Preview {
	CarriersListView(directionTitle: "Москва (Ярославский вокзал) ➔ Санкт-Петербург (Балтийский вокзал)")
}
