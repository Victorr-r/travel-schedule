import SwiftUI

struct CitiesListView: View {
	@Environment(\.dismiss) private var dismiss
	@Binding var selectedFinalDestination: String
	@State private var searchString = ""
	
	let cities = [
		"Москва",
		"Санкт-Петербург",
		"Сочи",
		"Горный воздух",
		"Краснодар",
		"Казань",
		"Омск"
	]
	
	var searchResults: [String] {
		if searchString.isEmpty {
			return cities
		} else {
			return cities.filter { $0.localizedCaseInsensitiveContains(searchString) }
		}
	}
	
	var body: some View {
		NavigationStack {
			ZStack {
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
							
							Text("Выбор города")
								.font(.system(size: 17, weight: .bold))
								.foregroundColor(Color(.ypBlack))
							
							Spacer()
							
							Image(systemName: "chevron.left")
								.font(.system(size: 17, weight: .bold))
								.opacity(0)
						}
						.padding(.horizontal, 36)
						.padding(.top, 11)
						.padding(.bottom, 11)
						
						HStack(spacing: 0) {
							HStack(spacing: 8) {
								Image(systemName: "magnifyingglass")
									.font(.system(size: 17))
									.foregroundColor(.gray)
								
								TextField("Введите запрос", text: $searchString)
									.font(.system(size: 17))
									.foregroundColor(Color(.ypBlack))
								
								if !searchString.isEmpty {
									Button(action: { searchString = "" }) {
										Image(systemName: "xmark.circle.fill")
											.font(.system(size: 17))
											.foregroundColor(.gray)
									}
								}
							}
							.padding(.horizontal, 12)
							.frame(height: 36)
							.background(Color(.ypLightGray))
							.cornerRadius(10)
						}
						.padding(.horizontal, 16)
						.padding(.bottom, 8)
					}
					
					if searchResults.isEmpty {
						Spacer()
						Text("Город не найден")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color(.ypBlack))
							.multilineTextAlignment(.center)
						Spacer()
					} else {
						ScrollView(.vertical, showsIndicators: false) {
							LazyVStack(spacing: 4) {
								ForEach(searchResults, id: \.self) { city in
									NavigationLink(destination: StationsListView(chosenCity: city, selectedFinalDestination: $selectedFinalDestination, onStationSelected: {
										dismiss()
									})) {
										HStack(spacing: 0) {
											Text(city)
												.font(.system(size: 17, weight: .regular))
												.foregroundColor(Color(.ypBlack))
											
											Spacer()
											
											Image(systemName: "chevron.right")
												.font(.system(size: 14, weight: .semibold))
												.foregroundColor(Color(.ypBlack))
										}
										.padding(.horizontal, 16)
										.frame(maxWidth: .infinity)
										.frame(height: 60)
										.background(Color(.ypWhite))
									}
								}
							}
							.padding(.top, 4)
						}
					}
				}
			}
		}
	}
}

#Preview {
	CitiesListView(selectedFinalDestination: .constant("Москва"))
}
