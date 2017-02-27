//
//  Reachability.swift
//  iTunesAppsLibrary
//
//  Created by Arturo Murillo on 2/27/17.
//  Copyright © 2017 Arturo Murillo. All rights reserved.
//

import Foundation
import Alamofire
import BRYXBanner

class Reachability {
    
    fileprivate let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    fileprivate var errorBanner: Banner?
    
    func listenForReachability() {
        self.reachabilityManager?.listener = { [weak self] status in
            switch status {
            case .notReachable:
            self?.showConnectionError()
            case .reachable(_), .unknown:
                self?.errorBanner?.dismiss()
            }
        }
        
        self.reachabilityManager?.startListening()
    }
    
    fileprivate func showConnectionError() {
        errorBanner = Banner(title: LocalizableString.offlineMessageTitle.localizedString, subtitle: LocalizableString.offlineMessage.localizedString, image:nil, backgroundColor: UIColor(red:198.0/255.0, green:26.00/255.0, blue:27.0/255.0, alpha:1.000))
        errorBanner!.dismissesOnTap = false
        errorBanner!.show()
    }
}
