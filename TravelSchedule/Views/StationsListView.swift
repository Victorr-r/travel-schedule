import SwiftUI

struct StationsListView: View {
	@Environment(\.dismiss) private var dismiss
	var chosenCity: String
	@Binding var selectedFinalDestination: String
	var onStationSelected: () -> Void
	@State private var searchString = ""
	
	let stations = [
		"Киевский вокзал",
		"Курский вокзал",
		"Ярославский вокзал",
		"Белорусский вокзал",
		"Савёловский вокзал",
		"Ленинградский вокзал"
	]
	
	var searchResults: [String] {
		if searchString.isEmpty {
			return stations
		} else {
			return stations.filter { $0.localizedCaseInsensitiveContains(searchString) }
		}
	}
	
	var body: some View {
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
						
						Text("Выбор станции")
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
					Text("Станция не найдена")
						.font(.system(size: 24, weight: .bold))
						.foregroundColor(Color(.ypBlack))
						.multilineTextAlignment(.center)
					Spacer()
				} else {
					ScrollView(.vertical, showsIndicators: false) {
						LazyVStack(spacing: 4) {
							ForEach(searchResults, id: \.self) { station in
								Button(action: {
									selectedFinalDestination = "\(chosenCity) (\(station))"
									onStationSelected()
								}) {
									HStack(spacing: 0) {
										Text(station)
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
		.navigationBarHidden(true)
	}
}

#Preview {
	StationsListView(chosenCity: "Москва", selectedFinalDestination: .constant(""), onStationSelected: {})
}
