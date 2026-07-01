import SwiftUI

struct ContentView: View {
	@State private var selectedTab = 0
	@State private var departureStation = ""
	@State private var arrivalStation = ""
	@State private var showDepartureSelection = false
	@State private var showArrivalSelection = false
	
	var body: some View {
		TabView(selection: $selectedTab) {
			NavigationStack {
				ZStack {
					Color.white
						.ignoresSafeArea()
					
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
											.foregroundColor(departureStation.isEmpty ? .gray : Color("YP Black"))
										Spacer()
									}
									.padding(.horizontal, 16)
									.frame(height: 48)
								}
								
								Button(action: { showArrivalSelection = true }) {
									HStack {
										Text(arrivalStation.isEmpty ? "Куда" : arrivalStation)
											.font(.system(size: 17, weight: .regular))
											.foregroundColor(arrivalStation.isEmpty ? .gray : Color("YP Black"))
										Spacer()
									}
									.padding(.horizontal, 16)
									.frame(height: 48)
								}
							}
							.background(Color.white)
							.cornerRadius(12)
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
							Button(action: {
								
							}) {
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
			.sheet(isPresented: $showDepartureSelection) {
				CitiesListView(selectedCity: $departureStation)
			}
			.sheet(isPresented: $showArrivalSelection) {
				CitiesListView(selectedCity: $arrivalStation)
			}
			.tabItem {
				Image("icSchedule")
					.renderingMode(.template)
			}
			.tag(0)
			
			NavigationStack {
				ZStack {
					Color.white
						.ignoresSafeArea()
					Text("Экран настроек (Заглушка)")
						.foregroundColor(Color("YP Black"))
				}
			}
			.tabItem {
				Image("icSettings")
					.renderingMode(.template)
			}
			.tag(1)
		}
		.tint(Color("YP Black"))
		.toolbarBackground(.white, for: .tabBar)
		.toolbarBackground(.visible, for: .tabBar)
		.preferredColorScheme(.light)
	}
}

#Preview {
	ContentView()
}
