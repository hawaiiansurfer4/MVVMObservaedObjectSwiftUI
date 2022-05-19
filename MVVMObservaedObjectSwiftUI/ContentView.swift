//
//  ContentView.swift
//  MVVMObservaedObjectSwiftUI
//
//  Created by Sean Murphy on 5/19/22.
//

import SwiftUI

let apiUrl = "https://api.letsbuildthatapp.com/static/courses.json"

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Hello Everyone from YOUTUBE")
            }.navigationBarTitle("Courses")
                .navigationBarItems(trailing: Button(action: {
                    print("Fetching json data")
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
