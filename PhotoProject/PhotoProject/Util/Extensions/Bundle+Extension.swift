//
//  Bundle+Extension.swift
//  PhotoProject
//
//  Created by 김도형 on 1/19/25.
//

import Foundation

extension Bundle {
    var clientId: String {
        return infoDictionary?["Client_ID"] as? String ?? ""
    }
}
