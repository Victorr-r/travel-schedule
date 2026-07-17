import SwiftUI

struct ContentView: View {
	@AppStorage("isDarkMode") private var isDarkMode = false
	@State private var selectedTab = 0
	@State private var departureStation = ""
	@State private var arrivalStation = ""
	@State private var showDepartureSelection = false
	@State private var showArrivalSelection = false
	@State private var showStories = false
	@State private var storiesList = Story.allStories
	@State private var selectedStoryID: UUID? = nil
	
	@StateObject private var errorSimulator = NetworkErrorSimulator()
	
	var body: some View {
		ZStack {
			if let error = errorSimulator.activeError {
				ZStack(alignment: .bottom) {
					ErrorView(
						imageName: error == .server ? "ilServer Error" : "ilNo Internet",
						title: error == .server ? "Ошибка сервера" : "Нет интернета"
					)
					
					Button(action: { errorSimulator.activeError = nil }) {
						Text("Сбросить ошибку (Вернуть сеть)")
							.font(.system(size: 14, weight: .bold))
							.foregroundColor(Color(.ypBlue))
							.padding()
							.background(Color(.ypWhite))
							.cornerRadius(10)
							.shadow(radius: 5)
					}
					.padding(.bottom, 50)
				}
			} else {
				TabView(selection: $selectedTab) {
					NavigationStack {
						ZStack {
							Color(.ypWhite)
								.ignoresSafeArea()
							
							VStack(spacing: 0) {
								ScrollView(.horizontal, showsIndicators: false) {
									HStack(spacing: 12) {
										ForEach(storiesList) { story in
											Button(action: {
												selectedStoryID = story.id
												showStories = true
											}) {
												Image(story.previewImage)
													.resizable()
													.scaledToFill()
													.frame(width: 92, height: 140)
													.opacity(story.isWatched ? 0.5 : 1.0)
													.clipShape(RoundedRectangle(cornerRadius: 16))
													.overlay(
														RoundedRectangle(cornerRadius: 16)
															.stroke(Color(.ypBlue), lineWidth: story.isWatched ? 0 : 4)
													)
											}
											.buttonStyle(PlainButtonStyle())
										}
									}
									.padding(.horizontal, 16)
								}
								.padding(.top, 24)
								.padding(.bottom, 20)
								.fullScreenCover(isPresented: $showStories) {
									StoriesView(stories: $storiesList, isPresented: $showStories, startStoryID: selectedStoryID)
								}
								
								ZStack(alignment: .trailing) {
									VStack(spacing: 0) {
										Button(action: { showDepartureSelection = true }) {
											HStack {
												Text(departureStation.isEmpty ? "Откуда" : departureStation)
													.font(.system(size: 17, weight: .regular))
													.foregroundColor(departureStation.isEmpty ? Color(.systemGray) : Color(.ypBlack))
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
													.foregroundColor(arrivalStation.isEmpty ? Color(.systemGray) : Color(.ypBlack))
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
									.padding(.vertical, 16)
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
								.background(Color(.ypBlue))
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
											.background(Color(.ypBlue))
											.cornerRadius(16)
									}
									.padding(.top, 16)
								}
								
								Spacer()
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
					
					SettingsView(errorSimulator: errorSimulator)
						.tabItem {
							Image("icSettings")
								.renderingMode(.template)
						}
						.tag(1)
				}
				.tint(Color(.ypBlack))
				.toolbarBackground(Color(.ypWhite), for: .tabBar)
				.toolbarBackground(.visible, for: .tabBar)
			}
		}
		.preferredColorScheme(isDarkMode ? .dark : .light)
	}
}

#Preview {
	ContentView()
}
