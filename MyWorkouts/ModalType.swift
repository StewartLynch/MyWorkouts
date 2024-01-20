//
// Created for MyWorkouts
// by  Stewart Lynch on 2024-01-19
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

import SwiftUI
enum ModalType: View, Identifiable, Equatable {
    case newActivity
    case updateActivity(Activity)
    case newWorkout(Activity)
    case updateWorkout(Workout)
    
    var id: String {
        switch self {
        case .newActivity:
            "newActivity"
        case .updateActivity:
            "updateActivity"
        case .newWorkout:
            "newWorkout"
        case .updateWorkout:
            "updateWorkout"
        }
    }
    
    var body: some View {
        switch self {
        case .newActivity:
            ActivityFormView(model: ActivityFormModel())
        case .updateActivity(let activity):
            ActivityFormView(model: ActivityFormModel(activity: activity))
        case .newWorkout(let activity):
            WorkoutFormView(model: WorkoutFormModel(activity: activity))
        case .updateWorkout(let workout):
            WorkoutFormView(model: WorkoutFormModel(workout: workout))
        }
    }
}

