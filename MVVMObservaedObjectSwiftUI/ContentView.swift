//
//  ContentView.swift
//  MVVMObservaedObjectSwiftUI
//
//  Created by Sean Murphy on 5/19/22.
//

import SwiftUI
import UIKit

let apiUrl = "https://api.letsbuildthatapp.com/static/courses.json"

struct Course: Identifiable, Codable {
    var id = UUID()
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

class CoursesViewModel: ObservableObject {
    @Published var messages = "Messages inside observable oject"
    @Published var courses = [Course]()
    var coursesToShow: [String] = []
    func changeMessage() {
        self.messages = "Blah Blah Blah"
    }

    func fetchCourses() {
        guard let url = URL(string: apiUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = try session.dataTask(with: url) { data, resp, error in
            if error != nil {
                return
            }
            if let safeData = data {

                self.parseJSON(safeData)
            }
        }.resume()
    }

    func parseJSON(_ courseData: Data) -> [Course]? {
        let decoderr = JSONDecoder()

        do {
            let decodedCourses = try decoderr.decode(Course.self, from: courseData)
            for i in decodedCourses.name {
                coursesToShow.append(String(i))
                courses.append(decodedCourses as Course)
            }
        } catch {
            return nil
        }
        return courses
    }
}

struct ContentView: View {

    @ObservedObject var coursesVM = CoursesViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                Text(coursesVM.messages)

                ForEach(coursesVM.courses) { course in
                    Text(course.name)
                }
            }.navigationBarTitle("Courses")
                .navigationBarItems(trailing: Button(action: {
                print("Fetching json data")
                self.coursesVM.fetchCourses()
            }, label: {
                    Text("Fetch Courses")
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
