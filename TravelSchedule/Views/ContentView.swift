import SwiftUI

struct ContentView: View {
	@State private var viewModel = ContentViewModel()
	
	var body: some View {
		VStack(spacing: 16) {
			Image(systemName: viewModel.isDiagnosticComplete ? "tram.fill" : "network")
				.font(.system(size: 64))
				.foregroundStyle(viewModel.isDiagnosticComplete ? .blue : .orange)
			
			Text("Travel Schedule")
				.font(.title)
				.bold()
			
			Text(viewModel.statusMessage)
				.font(.body)
				.foregroundStyle(.secondary)
				.multilineTextAlignment(.center)
		}
		.padding()
		.task {
			await viewModel.runYandexServicesDiagnostic()
		}
	}
}

#Preview {
	ContentView()
}
