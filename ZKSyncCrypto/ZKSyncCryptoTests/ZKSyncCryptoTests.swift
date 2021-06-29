//
//  ZKSyncCryptoTests.swift
//  ZKSyncCryptoTests
//
//  Made with ❤️ by Matter Labs on 10/23/20
//

import XCTest
import ZKSyncCrypto

class ZKSyncCryptoTests: XCTestCase {
    
    private var seed = Data(Array(repeating: 0, count: 32))
    private var message = "hello"
    
    func convertToData(_ value: [Int8]) -> Data {
        return Data(value.map { UInt8(bitPattern: $0) })
    }
    
    func testGeneratePrivateKey() {
        guard case let .success(privateKey) = ZKSyncCrypto.generatePrivateKey(seed: seed) else {
            XCTFail("Fail generating private key")
            return
        }
        
        let expected: [Int8] = [1, 31, 91, -103, 8, 76, 92, 46, 45, 94, 99, 72, -114, 15, 113, 104, -43, -103, -91, -64, 31, -23, -2, -60, -55, -106, 5, 116, 61, -91, -24, 92]
        
        XCTAssertEqual(privateKey.data(), convertToData(expected))
    }
    
    func testGetPublicKey() {
        guard case let .success(privateKey) = ZKSyncCrypto.generatePrivateKey(seed: seed) else {
            XCTFail("Fail generating private key")
            return
        }
        
        guard case let .success(publicKey) = ZKSyncCrypto.getPublicKey(privateKey: privateKey) else {
            XCTFail("Fail generating public key")
            return
        }
        
        let expected: [Int8] = [23, -100, 58, 89, 20, 125, 48, 49, 108, -120, 102, 40, -123, 35, 72, -55, -76, 42, 24, -72, 33, 8, 74, -55, -17, 121, -67, 115, -23, -71, 78, -115]
        
        XCTAssertEqual(publicKey.data(), convertToData(expected))
    }
    
    func testGetPublicKeyHash() {
        guard case let .success(privateKey) = ZKSyncCrypto.generatePrivateKey(seed: seed) else {
            XCTFail("Fail generating private key")
            return
        }
        
        guard case let .success(publicKey) = ZKSyncCrypto.getPublicKey(privateKey: privateKey) else {
            XCTFail("Fail generating public key")
            return
        }
        
        guard case let .success(publicKeyHash) = ZKSyncCrypto.getPublicKeyHash(publicKey: publicKey) else {
            XCTFail("Fail generating public hash key")
            return
        }
        
        let expected: [Int8] = [-57, 113, 39, 22, -71, -17, 107, -46, 23, 83, -60, -23, 29, -20, -61, 81, -79, 17, -64, 109]
        
        XCTAssertEqual(publicKeyHash.data(), convertToData(expected))
    }
    
    func testSignMessage() {
        guard case let .success(privateKey) = ZKSyncCrypto.generatePrivateKey(seed: seed) else {
            XCTFail("Fail generating private key")
            return
        }
        
        guard case let .success(signature) = ZKSyncCrypto.signMessage(privateKey: privateKey, message: message) else {
            XCTFail("Fail generating signature")
            return
        }
        

        let expected: [Int8] = [66, 111, 115, 126, -54, 53, 46, -4, 88, -107, 33, 63, -100, -36, -54, -112, -94, 98, 68, -8, 76, -62, -107, -64, 31, 0, 20, 92, 6, -56, 13, 37, 62, 28, -71, -3, 66, -73, 96, -128, -60, -45, 32, 85, -74, -119, -22, 62, 1, -27, 111, -104, -128, -29, -111, 47, -101, 27, -103, -63, -28, 91, 80, 4]
        
        XCTAssertEqual(signature.data(), convertToData(expected))
    }
    
    func testErronOnSeedTooShort() {
        let seed = Data([0])
        
        guard case let .error(error) = ZKSyncCrypto.generatePrivateKey(seed: seed) else {
            XCTFail("Incorrect private key generated")
            return
        }
        
        XCTAssertEqual(error as! ZKSyncCryptoError, ZKSyncCryptoError.seedTooShortError)
    }
    
    func testErrorOnMusigMessageTooLong() {
        guard case let .success(privateKey) = ZKSyncCrypto.generatePrivateKey(seed: seed) else {
            XCTFail("Fail generating private key")
            return
        }
        
        let message = Data(Array(repeating: 0, count: 93))

        guard case let .error(error) = ZKSyncCrypto.signMessage(privateKey: privateKey, message: message) else {
            XCTFail("Incorrect signature generated")
            return
        }

        XCTAssertEqual(error as! ZKSyncCryptoError, ZKSyncCryptoError.musigTooLongError)
    }
}
