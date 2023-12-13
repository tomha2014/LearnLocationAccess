//
//  UserLocationManager.swift
//  LearnLocationAccess
//
//  Created by tom hackbarth on 12/11/23.
//

import Foundation
import CoreLocation

final class UserLocationManager : NSObject, ObservableObject, CLLocationManagerDelegate{
        
    @Published var currentCoordinate: CLLocation = CLLocation(latitude: CLLocationCoordinate2D.denver.latitude, longitude: CLLocationCoordinate2D.denver.longitude)

    @Published var speed: CGFloat = 0    
    @Published var usersBreadCrumbs: [CLLocation] = []
    
    var locationManager: CLLocationManager?
    let persionLevel:Double = 100
    
    override init(){
        super.init()
        checkIfLocationServericesIsEnabled()
        startTracking()
    }
    
    func updateLocation(location: CLLocation){
        addBreadCrumb(location: location)
        currentCoordinate = location
    }
    
    func startTracking(){
        guard let locationManager = locationManager else {
            return
        }
        locationManager.startUpdatingLocation()
    }

    func stopTracking(){
        guard let locationManager = locationManager else {
            return
        }
        locationManager.stopUpdatingLocation()
    }
    
    func addBreadCrumb(location: CLLocation)  {
        usersBreadCrumbs.append(location)
    }
}


extension UserLocationManager{

    private func checkIfLocationServericesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.activityType = .fitness
            locationManager!.distanceFilter = 10.0
        }else{
            print("show Error")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        speed = location.speed
        updateLocation(location: location)
    }
    
    private func checkLocationAuth(){
        
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print(".restricted")
        case .denied:
            print(".denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print(".authorizedWhenInUse or .authorizedAlways")
            guard let location = locationManager.location else {
                break
            }
            updateLocation(location: location)
            break
        @unknown default:
            break
        }
    }
}
