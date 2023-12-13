//
//  ContentView.swift
//  LearnLocationAccess
//
//  Created by tom hackbarth on 12/11/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject private var viewModel : UserLocationManager
    @State private var currentUserPosition : MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        VStack {
            Map(position: $currentUserPosition){
                UserAnnotation()
            }
            HStack{
                Button("Start Tracking") {
                    
                    viewModel.startTracking()
                }
                Button("Stop Tracking") {
                    viewModel.stopTracking()
                }
            }
        }
        .onAppear(){
            CLLocationManager().requestWhenInUseAuthorization()
        }
        
    }
}

#Preview {
    ContentView()
}
