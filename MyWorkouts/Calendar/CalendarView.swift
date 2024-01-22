//
// Created for Custom Calendar
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

struct CalendarView: View {
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    let selectedActivity: Activity?
    @Query private var workouts: [Workout]
    @State private var counts = [Int : Int]()
    
    // Extension properties to display selected day's workouts
    @State private var selectedDay: Date?
    @State private var workoutsByDay: [Workout] = []

    
    init(date: Date, selectedActivity: Activity?) {
        self.date = date
        self.selectedActivity = selectedActivity
        let endOfMonthAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: date.endOfMonth)!
        let predicate = #Predicate<Workout> {$0.date >= date.startOfMonth && $0.date <= endOfMonthAdjustment}
        _workouts = Query(filter: predicate, sort: \Workout.date)
    }
    var body: some View {
        let color = selectedActivity == nil ? .blue : Color(hex: selectedActivity!.hexColor)!
        VStack {
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(color)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay
                                        ? .red.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                        :  color.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                    )
                            )
                            .overlay(alignment: .bottomTrailing) {
                                if let count = counts[day.dayInt] {
                                    Image(systemName: count <= 50 ? "\(count).circle.fill" : "plus.circle.fill")
                                        .foregroundColor(.secondary)
                                        .imageScale(.medium)
                                        .background (
                                            Color(.systemBackground)
                                                .clipShape(.circle)
                                        )
                                        .offset(x: 5, y: 5)
                                }
                            }
                            .onTapGesture {
                                // Used in the ExtendedProject branch
                                if let count = counts[day.dayInt], count > 0 {
                                    selectedDay = day
                                } else {
                                    selectedDay = nil
                                }
                            }
                    }
                }
            }
            if let selectedDay {
                // Presents the list of workouts for the selected day and activity
                WorkoutListView(day: selectedDay, workouts: workoutsByDay)
            }
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
            setupCounts()
            selectedDay = nil // Used to present list of workouts when tapped
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
            setupCounts()
            selectedDay = nil // Used to present list of workouts when tapped
        }
        
        .onChange(of: selectedActivity) {
            setupCounts()
            selectedDay = nil // Used to present list of workouts when tapped
        }
        .onChange(of: selectedDay) {
            // Will filter the workouts for the specific day and activity is selected
            if let selectedDay {
                workoutsByDay = workouts.filter {$0.date.dayInt == selectedDay.dayInt}
                if let selectedActivity {
                    workoutsByDay = workoutsByDay.filter { $0.activity == selectedActivity}
                }
            }
        }
    }
    
    func setupCounts() {
        var filteredWorkouts = workouts 
        if let selectedActivity {
            filteredWorkouts = workouts.filter {$0.activity == selectedActivity}
        }
        let mappedItems = filteredWorkouts.map{($0.date.dayInt, 1)}
        counts = Dictionary(mappedItems, uniquingKeysWith: +)
    }
    
    
}

#Preview {
    CalendarView(date: Date.now, selectedActivity: nil)
        .modelContainer(Activity.preview)
}
