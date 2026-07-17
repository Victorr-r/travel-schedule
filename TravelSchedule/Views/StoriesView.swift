import SwiftUI
import Combine

struct StoriesView: View {
	struct Configuration {
		let timerTickInterval: TimeInterval
		let progressPerTick: CGFloat
		
		init(storiesCount: Int, secondsPerStory: TimeInterval = 5, timerTickInterval: TimeInterval = 0.02) {
			self.timerTickInterval = timerTickInterval
			self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInterval
		}
	}
	
	@Binding var stories: [Story]
	@Binding var isPresented: Bool
	let configuration: Configuration
	
	@AppStorage(StorageKeys.isDarkMode) private var isDarkMode = false
	@State private var progress: CGFloat = 0
	@State private var timer: Timer.TimerPublisher
	@State private var cancellable: Cancellable?
	@State private var currentTabID: UUID
	
	private var currentStoryIndex: Int {
		stories.firstIndex(where: { $0.id == currentTabID }) ?? 0
	}
	
	private var currentStory: Story {
		stories[currentStoryIndex]
	}
	
	init(stories: Binding<[Story]>, isPresented: Binding<Bool>, startStoryID: UUID?) {
		self._stories = stories
		self._isPresented = isPresented
		let initialID = startStoryID ?? stories.wrappedValue.first?.id ?? UUID()
		self._currentTabID = State(initialValue: initialID)
		
		let count = stories.wrappedValue.count
		let config = Configuration(storiesCount: count)
		self.configuration = config
		
		let initialProgress = CGFloat(stories.wrappedValue.firstIndex(where: { $0.id == initialID }) ?? 0) / CGFloat(count)
		self._progress = State(initialValue: initialProgress)
		self._timer = State(initialValue: Timer.publish(every: config.timerTickInterval, on: .main, in: .common))
	}
	
	var body: some View {
		ZStack(alignment: .bottomLeading) {
			TabView(selection: $currentTabID) {
				ForEach(stories) { story in
					storyContent(for: story)
						.tag(story.id)
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.ignoresSafeArea()
			
			VStack(alignment: .leading, spacing: 10) {
				Text(currentStory.title)
					.font(.system(size: 34, weight: .bold))
					.foregroundColor(.white)
				
				Text(currentStory.description)
					.font(.system(size: 20, weight: .regular))
					.foregroundColor(.white)
					.lineLimit(3)
					.multilineTextAlignment(.leading)
			}
			.padding(.horizontal, 16)
			.padding(.bottom, 24)
			
			VStack(spacing: 0) {
				ZStack(alignment: .topTrailing) {
					ProgressBar(numberOfSections: stories.count, progress: progress)
						.frame(width: 351, height: 6)
						.padding(.top, 35)
						.padding(.horizontal, 12)
					
					Button(action: {
						isPresented = false
					}) {
						Image(systemName: "xmark.circle.fill")
							.font(.system(size: 30))
							.foregroundStyle(.white, Color(red: 26/255, green: 27/255, blue: 34/255))
					}
					.padding(.trailing, 12)
					.padding(.top, 57)
				}
				.frame(width: 375, height: 100)
				.padding(.top, 7)
				
				Spacer()
			}
			.ignoresSafeArea()
		}
		.contentShape(Rectangle())
		.onTapGesture {
			nextStory()
			resetTimer()
		}
		.preferredColorScheme(isDarkMode ? .dark : .light)
		.onChange(of: currentTabID) { oldValue, newValue in
			markAsWatched(id: newValue)
			let index = stories.firstIndex(where: { $0.id == newValue }) ?? 0
			progress = CGFloat(index) / CGFloat(stories.count)
			resetTimer()
		}
		.onAppear {
			markAsWatched(id: currentTabID)
			timer = Timer.publish(every: configuration.timerTickInterval, on: .main, in: .common)
			cancellable = timer.connect()
		}
		.onDisappear {
			cancellable?.cancel()
		}
		.onReceive(timer) { _ in
			timerTick()
		}
	}
	
	@ViewBuilder
	private func storyContent(for story: Story) -> some View {
		ZStack {
			story.backgroundColor
				.ignoresSafeArea()
			
			Image(story.previewImageName)
				.resizable()
				.scaledToFill()
				.ignoresSafeArea()
		}
	}
	
	private func timerTick() {
		let nextProgress = progress + configuration.progressPerTick
		let maxProgressForCurrent = CGFloat(currentStoryIndex + 1) / CGFloat(stories.count)
		
		if nextProgress >= maxProgressForCurrent {
			let nextIndex = currentStoryIndex + 1
			if nextIndex < stories.count {
				currentTabID = stories[nextIndex].id
			} else {
				isPresented = false
			}
		} else {
			progress = nextProgress
		}
	}
	
	private func nextStory() {
		let nextIndex = currentStoryIndex + 1
		if nextIndex < stories.count {
			currentTabID = stories[nextIndex].id
		} else {
			isPresented = false
		}
	}
	
	private func resetTimer() {
		cancellable?.cancel()
		timer = Timer.publish(every: configuration.timerTickInterval, on: .main, in: .common)
		cancellable = timer.connect()
	}
	
	private func markAsWatched(id: UUID) {
		if let index = stories.firstIndex(where: { $0.id == id }) {
			stories[index] = stories[index].with(isWatched: true)
		}
	}
}
