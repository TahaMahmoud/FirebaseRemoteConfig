//
//  RCValues.swift
//  RemoteConfig
//
//  Created by Taha on 20/04/2022.
//

import Foundation
import Firebase

class RemoteDataManager {
    
    static let sharedInstance = RemoteDataManager()

    private init() {
        loadDefaultValues()
    }

    func loadDefaultValues() {
    let appDefaults: [String: Any?] = [
        "dynamicLabel": "DynamicLabel"
    ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
          let settings = RemoteConfigSettings()
          // WARNING: Don't actually do this in production!
          settings.minimumFetchInterval = 0
          RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues(onComplete: @escaping ((String?, Error?) -> ()) ) {
        
        activateDebugMode()

        RemoteConfig.remoteConfig().fetch { value, error in
              
            print(value)
            
            if let error = error {
                onComplete(nil, error)
                return
            }

            RemoteConfig.remoteConfig().activate { _, _ in
                onComplete((RemoteConfig.remoteConfig().configValue(forKey: "dynamicLabel").stringValue ?? "Undefined"), nil)
            }
        }
    }
    
}
