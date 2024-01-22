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

struct WorkoutListView: View {
    let day: Date
    var  workouts: [Workout]
    var filteredWorkouts: [Workout] = []
    
    init(day: Date, workouts: [Workout]) {
        self.day = day
        self.workouts = workouts
        self.filteredWorkouts = workouts.filter{ $0.date.startOfDay == day.startOfDay  }
    }
    

    var body: some View {
        VStack(alignment: .leading){
            Text("Workouts")
            List (filteredWorkouts) { workout in
                HStack {
                    Image(systemName: workout.activity?.icon ?? ActivitySymbol.mixedCardio.rawValue)
                        .foregroundStyle(Color(hex: workout.activity!.hexColor)!)
                    VStack(alignment: .leading) {
                        Text(workout.date.formatted(date: .abbreviated, time: .shortened))
                        Text(workout.comment)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .listStyle(.plain)
        }
        .padding(.top)
    }
}

#Preview {
    WorkoutListView(day:Date.now, workouts: [])
        .modelContainer(Activity.preview)
}
