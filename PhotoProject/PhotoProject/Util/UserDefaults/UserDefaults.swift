//
//  UserDefaults.swift
//  PhotoProject
//
//  Created by 김도형 on 1/23/25.
//

import Foundation

@propertyWrapper
struct UserDefaults<T> {
    let key: String
    let defaultValue: T?
    
    init(forKey: String, defaultValue: T? = nil) {
        self.key = forKey
        self.defaultValue = defaultValue
        let object = Foundation.UserDefaults.standard.object(forKey: forKey)
        if object == nil && defaultValue != nil {
            Foundation.UserDefaults.standard.set(defaultValue, forKey: key)
        }
    }
    
    var wrappedValue: T? {
        get { (Foundation.UserDefaults.standard.object(forKey: key) as? T) ?? defaultValue }
        set {
            if newValue == nil {
                Foundation.UserDefaults.standard.removeObject(forKey: key)
            } else {
                Foundation.UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

enum UserDefaultsKey: String {
    case nickname = "Nickname"
    case birthday = "Birthday"
    case level = "Level"
    case authenticated = "Authenticated"
}

extension String {
    static func userDefaults(_ key: UserDefaultsKey) -> String {
        key.rawValue
    }
}
