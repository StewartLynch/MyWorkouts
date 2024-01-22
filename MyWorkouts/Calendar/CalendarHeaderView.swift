//
// Created for MyWorkouts
// by  Stewart Lynch on 2024-01-22
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import SwiftUI
import SwiftData

struct CalendarHeaderView: View {
    @State private var monthDate = Date.now
    @State private var years: [Int] = []
    @State private var selectedMonth = Date.now.monthInt
    @State private var selectedYear = Date.now.yearInt
    @Query private var workouts: [Workout]
    @Query(sort: \Activity.name) private var activities: [Activity]
    @State private var selectedActivity: Activity?
    
    let months = Date.fullMonthNames
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $selectedActivity) {
                    Text("All").tag(nil as Activity?)
                    ForEach(activities) { activity in
                        Text(activity.name).tag(activity as Activity?)
                    }
                }
                .buttonStyle(.borderedProminent)
                HStack {
                    Picker("", selection: $selectedYear) {
                        ForEach(years, id:\.self) { year in
                            Text(String(year))
                        }
                    }
                    Picker("", selection: $selectedMonth) {
                        ForEach(months.indices, id: \.self) { index in
                            Text(months[index]).tag(index + 1)
                        }
                    }
                }
                .buttonStyle(.bordered)
                CalendarView(date: monthDate, selectedActivity: selectedActivity)
                Spacer()
            }
            .navigationTitle("Tallies")
        }
        .onAppear {
            years = Array(Set(workouts.map {$0.date.yearInt}.sorted()))
        }
        .onChange(of: selectedYear) {
            updateDate()
        }
        .onChange(of: selectedMonth) {
            updateDate()
        }
    }
    
    func updateDate() {
        monthDate = Calendar.current.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: 1))!
    }
}

#Preview {
    CalendarHeaderView()
        .modelContainer(Activity.preview)
}
