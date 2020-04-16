//
//  ImageLoader.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/16/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class ImageLoader {
    
    // MARK: - Properties
    
    static let shared = ImageLoader()
    
    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    // MARK: - Functions
    
    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .print("Image loading \(url):")
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

