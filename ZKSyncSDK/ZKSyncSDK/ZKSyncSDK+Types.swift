//
//  ZKSyncSDK+Types.swift
//  ZKSyncSDK-UI
//
//  Made with ❤️ by Matter Labs on 10/23/20
//

import Foundation

public class ZKPrimitive {
    class var bytesLength: Int {
        return 0
    }
    
    private var content: Data
    
    public init(_ content: Data) {
        assert(content.count == Self.bytesLength, "Incorrect data length. Should be \(Self.bytesLength)")
        
        self.content = content
    }
    
    public convenience init(_ content: [UInt8]) {
        self.init(Data(content))
    }
    
    public func data() -> Data {
        return content
    }
    
    public func base64String() -> String {
        return content.base64EncodedString()
    }
    
    public func hexEncodedString() -> String {
        return content.map { String(format: "%02hhX", $0) }.joined()
    }
    
    func withUnsafeBytes<ResultType>(_ body: (UnsafeRawBufferPointer) throws -> ResultType) rethrows -> ResultType {
        return try! content.withUnsafeBytes(body)
    }
}

public class ZKPackedPublicKey: ZKPrimitive {
    override class var bytesLength: Int {
        return 32
    }
}

public class ZKPrivateKey: ZKPrimitive {
    override public class var bytesLength: Int {
        return 32
    }
}

public class ZKPublicHash: ZKPrimitive {
    override class var bytesLength: Int {
        return 20
    }
}

public class ZKSignature: ZKPrimitive {
    override class var bytesLength: Int {
        return 64
    }
}

public class ZKResqueHash: ZKPrimitive {
    override class var bytesLength: Int {
        return 31
    }
}

public enum ZKSyncSDKError: Error {
    case musigTooLongError
    case seedTooShortError
    case unsupportedOperation
}

typealias CLibZksPrivateKey = ZksPrivateKey
typealias CLibZksPackedPublicKey = ZksPackedPublicKey
typealias CLibZksPubkeyHash = ZksPubkeyHash
typealias CLibZksSignature = ZksSignature
typealias CLibZksResqueHash = ZksResqueHash
