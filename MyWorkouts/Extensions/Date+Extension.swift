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

import Foundation

extension Date {
    
    // Used to generate the mock data for previews
    // Computed property courtesy of ChatGPT
    var randomDateWithinLastThreeMonths: Date {
        let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: self)!
        let randomTimeInterval = TimeInterval.random(in: 0.0..<self.timeIntervalSince(threeMonthsAgo))
        let randomDate = threeMonthsAgo.addingTimeInterval(randomTimeInterval)
        return randomDate
    }
}
