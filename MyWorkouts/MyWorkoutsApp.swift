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
import SwiftData

@main
struct MyWorkoutsApp: App {
    var body: some Scene {
        WindowGroup {
            StartTab()
                .modelContainer(for: Activity.self)
        }
    }
}
