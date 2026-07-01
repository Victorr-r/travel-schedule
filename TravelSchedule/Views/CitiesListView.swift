import SwiftUI

struct CitiesListView: View {
	@Environment(\.dismiss) private var dismiss
	@Binding var selectedCity: String
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
				Color.white
					.ignoresSafeArea()
				
				VStack(spacing: 0) {
					HStack(spacing: 0) {
						HStack(spacing: 8) {
							Image(systemName: "magnifyingglass")
								.font(.system(size: 17))
								.foregroundColor(.gray)
							
							TextField("Введите запрос", text: $searchString)
								.font(.system(size: 17))
								.foregroundColor(Color("YP Black"))
							
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
						.background(Color(.systemGray6))
						.cornerRadius(10)
					}
					.padding(.horizontal, 16)
					.padding(.vertical, 8)
					
					if searchResults.isEmpty {
						Spacer()
						Text("Город не найден")
							.font(.system(size: 24, weight: .bold))
							.foregroundColor(Color("YP Black"))
							.multilineTextAlignment(.center)
						Spacer()
					} else {
						List(searchResults, id: \.self) { city in
							Button(action: {
								selectedCity = city
								dismiss()
							}) {
								HStack {
									Text(city)
										.font(.system(size: 17, weight: .regular))
										.foregroundColor(Color("YP Black"))
									Spacer()
									Image(systemName: "chevron.right")
										.font(.system(size: 14, weight: .semibold))
										.foregroundColor(Color("YP Black"))
								}
								.padding(.vertical, 8)
							}
							.listRowBackground(Color.clear)
							.listRowSeparatorTint(Color.gray.opacity(0.2))
						}
						.listStyle(.plain)
					}
				}
			}
			.navigationTitle("Выбор города")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: { dismiss() }) {
						Image(systemName: "chevron.left")
							.font(.system(size: 17, weight: .bold))
							.foregroundColor(Color("YP Black"))
					}
				}
			}
		}
		.preferredColorScheme(.light)
	}
}

#Preview {
	CitiesListView(selectedCity: .constant("Москва"))
}
