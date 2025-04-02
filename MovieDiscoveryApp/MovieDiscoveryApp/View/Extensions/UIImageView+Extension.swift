//
//  UIImageView+Extension.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import UIKit
import Combine

extension UIImageView {
    private static var cancellableKey: UInt8 = 0
    private var cancellable: AnyCancellable? {
        get { objc_getAssociatedObject(self, &Self.cancellableKey) as? AnyCancellable }
        set { objc_setAssociatedObject(self, &Self.cancellableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(from url: String, placeholder: UIImage? = nil) {
        guard let imageUrl = URL(string: url) else { return }
        self.image = placeholder
        
        cancellable = ImageLoader.shared.loadImage(from: imageUrl)
            .sink { [weak self] image in
                self?.image = image
            }
    }
}

