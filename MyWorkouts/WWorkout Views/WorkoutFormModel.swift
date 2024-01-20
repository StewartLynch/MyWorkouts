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

@Observable
class WorkoutFormModel {
    var date: Date = Date.now
    var comment: String = ""
    var activity: Activity?
    var workout: Workout?
    var updating: Bool { workout != nil }
    
    init(activity: Activity) {
        self.activity = activity
        
    }
    
    init(workout: Workout) {
        self.workout = workout
        self.activity = workout.activity
        self.date = workout.date
        self.comment = workout.comment
    }
    
}
