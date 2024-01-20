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

import UIKit
import SwiftData

@Model class Activity {
    var name: String
    @Relationship(deleteRule: .cascade)
    var icon: ActivitySymbol.RawValue
    var hexColor: String
    var workouts: [Workout] = []
    init(name: String, icon: ActivitySymbol = .two, hexColor: String = "FF0000") {
        self.name = name
        self.icon = icon.rawValue
        self.hexColor = hexColor
    }
}

extension Activity {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Activity.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )
        var sampleActivities: [Activity] {
            [
                Activity(name: "Jogging", icon: .run, hexColor: "B33234"),
                Activity(name: "Swimming", icon: .poolSwim, hexColor: "6F223D"),
                Activity(name: "Biking", icon: .outdoorCycle, hexColor: "38571A"),
                Activity(name: "Elliptical", icon: .elliptical, hexColor: "FF3B30"),
            ]
        }
        
        let sampleComments =  [
            "Energized and alive!",
            "Sweaty but satisfied.",
            "On top of the world!",
            "Exhausted but accomplished.",
            "Muscles are singing!",
            "Feeling the burn in a good way.",
            "Empowered and strong.",
            "Ready to conquer the day.",
            "A good kind of soreness.",
            "Proud of the effort.",
            "Revitalized and refreshed.",
            "Endorphins pumping!",
            "Like a fitness superhero!",
            "Beaming with post-workout glow.",
            "Unstoppable and determined.",
            "Tired but triumphant.",
            "Fuelled with positive vibes.",
            "In love with the post-workout high.",
            "Feeling the progress.",
            "Champion mode activated!"
        ]

        sampleActivities.forEach { activity in
            container.mainContext.insert(activity)
            let randomNumber = Int.random(in: 15...50)
            for _ in 1...randomNumber {
                let randomComment = sampleComments[Int.random(in: 0..<sampleComments.count)]
                let newWorkOut = Workout(date: Date.now.randomDateWithinLastThreeMonths, comment: randomComment)
                activity.workouts.append(newWorkOut)
            }
        }
        return container
    }

}
