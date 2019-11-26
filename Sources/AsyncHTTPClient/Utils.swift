//===----------------------------------------------------------------------===//
//
// This source file is part of the AsyncHTTPClient open source project
//
// Copyright (c) 2018-2019 Apple Inc. and the AsyncHTTPClient project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AsyncHTTPClient project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import NIO
import NIOHTTP1
import Network

public final class HTTPClientCopyingDelegate: HTTPClientResponseDelegate {
    public typealias Response = Void

    let chunkHandler: (ByteBuffer) -> EventLoopFuture<Void>

    init(chunkHandler: @escaping (ByteBuffer) -> EventLoopFuture<Void>) {
        self.chunkHandler = chunkHandler
    }

    public func didReceiveBodyPart(task: HTTPClient.Task<Void>, _ buffer: ByteBuffer) -> EventLoopFuture<Void> {
        return self.chunkHandler(buffer)
    }

    public func didFinishRequest(task: HTTPClient.Task<Void>) throws {
        return ()
    }
}

internal extension String {
    var isIPAddress: Bool {
        if IPv4Address(self) != nil || IPv6Address(self) != nil {
            return true
        }
        return false
    }
}
