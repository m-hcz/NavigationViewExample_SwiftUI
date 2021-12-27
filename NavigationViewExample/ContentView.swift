//
//  ContentView.swift
//  NavigationViewExample
//
//  Created by M H on 27/12/2021.
//

import SwiftUI

class User: ObservableObject {
	@Published var score = 0
}


struct ChangeView: View {
	@EnvironmentObject var user: User
	
	var body: some View {
		VStack {
			Text("Score: \(user.score)")
			Button("Increse") {
				self.user.score += 1
			} // button
		} // vstack
	}
}


struct ContentView: View {
	
	@State private var isShowingDetailView = false
	@State private var fullScreen = false
	@State private var selection: String? = nil
	@ObservedObject var user = User()
	
	
    var body: some View {
		NavigationView {
			VStack(spacing: 30) {
				
				Divider()
					.padding(.horizontal)
				
				
				NavigationLink(destination: Text("Second view"), isActive: $isShowingDetailView, label: {
					Text("NavigationLink - isActive")
						.padding()
				}) // navlink

				Button("Button to show detail, isActive") {
					self.isShowingDetailView = true
					
					// desmiss after 2s (after loading)
					DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
						self.isShowingDetailView = false
					})
				} // button
				
				Divider()
					.padding(.horizontal)
				
				NavigationLink(destination: Text("Second view"), tag: "Second", selection: $selection, label: {
					Text("NavigationLink - tag, selection")
						.padding()
				}) // navlink
				
				Button("Button to show detail, selection") {
					self.selection = "Second"
				} // button
				
				Divider()
					.padding(.horizontal)
				
				NavigationLink(destination: ChangeView(), label: {
					Text("Show change view")
				}) // navlink
				
				Divider()
					.padding(.horizontal)
				
				Button("full screen") {
					self.fullScreen.toggle()
				} // button
			} // vstack
			

				.navigationBarTitle("Navigation") // .auto inherits
				.navigationBarItems(
					leading:
						Button(action: {
							self.user.score -= 1
						}, label: {
							Text("Subtract 1")
						}) // buuton
					,
					trailing:
						Button(action: {
							self.user.score += 1
						}, label: {
							Text("Add 1")
						}) // buuton
					) // navitems
				.navigationBarHidden(fullScreen)
		} // navview
		.environmentObject(user) // shows user everywhere
		.statusBar(hidden: fullScreen)
		.navigationViewStyle(StackNavigationViewStyle()) // for landscape and ipads disable side nav view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
