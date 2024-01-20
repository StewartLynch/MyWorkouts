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
class ActivityFormModel {
    var name = ""
    var icon: ActivitySymbol = .two
    var hexColor: Color = .red
    
    var activity: Activity?
    
    var updating: Bool { activity != nil }
    
    init() {}
    
    init(activity: Activity) {
        self.activity = activity
        self.name = activity.name
        self.icon = ActivitySymbol(rawValue: activity.icon) ?? .two
        self.hexColor = Color(hex: activity.hexColor)!
    }
    
    var disabled: Bool {
        name.isEmpty
    }
}
