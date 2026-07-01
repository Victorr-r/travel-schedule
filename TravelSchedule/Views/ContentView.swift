import SwiftUI

struct ContentView: View {
	@State private var selectedTab = 0
	@State private var departureStation = ""
	@State private var arrivalStation = ""
	@State private var showDepartureSelection = false
	@State private var showArrivalSelection = false
	
	@ObservedObject private var errorSimulator = NetworkErrorSimulator.shared
	
	var body: some View {
		TabView(selection: $selectedTab) {
			NavigationStack {
				ZStack {
					Color("YP White")
						.ignoresSafeArea()
					
					if let error = errorSimulator.activeError {
						ErrorView(
							imageName: error == .server ? "ilServer Error" : "ilNo Internet",
							title: error == .server ? "Ошибка сервера" : "Нет интернета"
						)
					} else {
						VStack(spacing: 0) {
							ScrollView(.horizontal, showsIndicators: false) {
								HStack(spacing: 12) {
									let storiesImages = ["Stories1", "Stories2", "Stories3", "Stories4"]
									ForEach(storiesImages, id: \.self) { imageName in
										Image(imageName)
											.resizable()
											.scaledToFill()
											.frame(width: 92, height: 140)
											.clipShape(RoundedRectangle(cornerRadius: 16))
									}
								}
								.padding(.leading, 16)
								.padding(.trailing, 16)
							}
							.padding(.top, 24)
							.padding(.bottom, 20)
							
							ZStack(alignment: .trailing) {
								VStack(spacing: 0) {
									Button(action: { showDepartureSelection = true }) {
										HStack {
											Text(departureStation.isEmpty ? "Откуда" : departureStation)
												.font(.system(size: 17, weight: .regular))
												.foregroundColor(departureStation.isEmpty ? Color(.systemGray) : Color("YP Black"))
												.lineLimit(1)
												.truncationMode(.tail)
											Spacer()
										}
										.padding(.horizontal, 16)
										.frame(height: 48)
									}
									
									Button(action: { showArrivalSelection = true }) {
										HStack {
											Text(arrivalStation.isEmpty ? "Куда" : arrivalStation)
												.font(.system(size: 17, weight: .regular))
												.foregroundColor(arrivalStation.isEmpty ? Color(.systemGray) : Color("YP Black"))
												.lineLimit(1)
												.truncationMode(.tail)
											Spacer()
										}
										.padding(.horizontal, 16)
										.frame(height: 48)
									}
								}
								.background(Color.white)
								.cornerRadius(12)
								.environment(\.colorScheme, .light)
								.padding(.leading, 16)
								.padding(.top, 16)
								.padding(.bottom, 16)
								.padding(.trailing, 68)
								
								Button(action: {
									let temp = departureStation
									departureStation = arrivalStation
									arrivalStation = temp
								}) {
									Image("Button 1")
										.resizable()
										.scaledToFit()
										.frame(width: 36, height: 36)
								}
								.padding(.trailing, 16)
							}
							.frame(maxWidth: .infinity)
							.background(Color("YP Blue"))
							.cornerRadius(20)
							.padding(.horizontal, 16)
							
							if !departureStation.isEmpty && !arrivalStation.isEmpty {
								NavigationLink(destination: CarriersListView(directionTitle: "\(departureStation) ➔ \(arrivalStation)")
									.toolbar(.hidden, for: .tabBar)
								) {
									Text("Найти")
										.font(.system(size: 17, weight: .bold))
										.foregroundColor(.white)
										.frame(width: 150, height: 60)
										.background(Color("YP Blue"))
										.cornerRadius(16)
								}
								.padding(.top, 16)
							}
							
							Spacer()
						}
					}
				}
			}
			.fullScreenCover(isPresented: $showDepartureSelection) {
				CitiesListView(selectedFinalDestination: $departureStation)
			}
			.fullScreenCover(isPresented: $showArrivalSelection) {
				CitiesListView(selectedFinalDestination: $arrivalStation)
			}
			.tabItem {
				Image("icSchedule")
					.renderingMode(.template)
			}
			.tag(0)
			
			VStack(spacing: 24) {
				Text("Настройки симуляции сети")
					.font(.system(size: 20, weight: .bold))
					.foregroundColor(Color("YP Black"))
				
				Button(action: { errorSimulator.activeError = nil }) {
					Text("Всё ок (Сеть работает)")
						.font(.system(size: 17, weight: .semibold))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.frame(height: 50)
						.background(errorSimulator.activeError == nil ? Color("YP Blue") : Color.gray)
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
			.padding(.top, 40)
			.background(Color("YP White").ignoresSafeArea())
			.tabItem {
				Image("icSettings")
					.renderingMode(.template)
			}
			.tag(1)
		}
		.tint(Color("YP Black"))
		.toolbarBackground(Color("YP White"), for: .tabBar)
		.toolbarBackground(.visible, for: .tabBar)
	}
}

#Preview {
	ContentView()
}
