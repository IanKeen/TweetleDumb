//
//  MockNetwork.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

/// Mock Network will attempt to return a json file 
/// whose filename matches the last component of the request
/// appending `.json` - so:
///
/// A request to `http://api.tweetledumb.com/auth` will
/// look for a file named `auth.json` and return it as `Data`
final class MockNetwork: Network {
    private let delay: Double
    private let randomErrors: Bool

    init(randomErrors: Bool = true, delay: Double = 3.0) {
        self.delay = delay
        self.randomErrors = randomErrors
    }

    // MARK: - Public Functions
    func perform(request: NetworkRequest, complete: @escaping RequestComplete) {
        do {
            let urlRequest = try request.buildURLRequest()

            guard let url = urlRequest.url else { throw Error.invalidURL }

            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                guard self.dontFail()
                    else { return DispatchQueue.main.async(execute: { complete(.failure(Error.random)) }) }

                guard
                    let path = self.file(for: url),
                    let data = try? Data(contentsOf: path)
                    else { return DispatchQueue.main.async(execute: { complete(.failure(Error.fileSource)) }) }

                let response = NetworkResponse(
                    response: HTTPURLResponse(
                        url: url,
                        mimeType: "application/json",
                        expectedContentLength: data.count,
                        textEncodingName: nil
                    ),
                    data: data
                )

                return DispatchQueue.main.async { complete(.success(response)) }
            }

        } catch let error {
            return DispatchQueue.main.async { complete(.failure(error)) }
        }
    }

    // MARK: - Private Functions
    private func dontFail() -> Bool {
        return !randomErrors || ((0..<10).random() ?? 0) < 5
    }
    private func file(for url: URL) -> URL? {
        return Bundle.main.url(forResource: (url.absoluteString as NSString).lastPathComponent, withExtension: "json")
    }
}
