//
//  ImageLoader.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import Foundation
import UIKit
import Combine

class ImageLoader {
    static let shared = ImageLoader()
    private var cache = NSCache<NSURL, UIImage>()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return Just(cachedImage).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .catch { _ in Just(nil) }
            .handleEvents(receiveOutput: { [weak self] image in
                if let image = image {
                    self?.cache.setObject(image, forKey: url as NSURL)
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
