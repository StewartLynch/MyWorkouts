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

struct ActivityListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var modalType: ModalType?
    @Query(sort: \Activity.name) private var activities: [Activity]
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(activities) { activity in
                NavigationLink(value: activity){
                    HStack {
                        Image(systemName: activity.icon)
                            .foregroundStyle(Color(hex: activity.hexColor)!)
                            .font(.system(size: 30))
                            .frame(width: 50)
                        Text(activity.name.capitalized)
                        Spacer()
                        Text("^[\(activity.workouts.count) workout](inflect: true)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        modelContext.delete(activity)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        modalType = .updateActivity(activity)
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Activities")
            .toolbar {
                Button {
                    modalType = .newActivity
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(item: $modalType) { sheet in
                    sheet
                        .presentationDetents([.height(450)])
                }
            }
            .navigationDestination(for: Activity.self) { activity in
                WorkoutsListView(activity: activity)
            }
            
        }
    }
}

#Preview {
    ActivityListView()
        .modelContainer(Activity.preview)
}


