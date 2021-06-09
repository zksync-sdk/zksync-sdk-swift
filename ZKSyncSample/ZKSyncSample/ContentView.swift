//
//  ContentView.swift
//  ZKSyncSDK-UI
//
//  Made with ❤️ by Matter Labs on 10/23/20
//

import SwiftUI
import ZKSyncCrypto

class ContentViewModel: ObservableObject {
    @Published var message: String = "Hello, world!"
    
    @Published var seedText: String = ""
    @Published var privateKey: String = ""
    @Published var publicKey: String = ""
    @Published var publicKeyHash: String = ""
    @Published var signature: String = ""
    
    init() {
        self.setNeedsToUpdate()
    }
    
    func setNeedsToUpdate() {
        self.configureSeed()
        self.configureKeys()
    }
    
    func configureSeed() {
        let sequence = [UInt8](0..<255)
        let shuffledSequence = sequence.shuffled().prefix(100)
        
        self.seedText = Data(shuffledSequence).base64EncodedString()
    }
    
    func configureKeys() {
        let seed = Data(base64Encoded: self.seedText)!
        
        guard let privateKey = createPrivateKey(seed: seed) else {
            return
        }
        
        guard let publicKey = createPublicKey(privateKey: privateKey) else {
            return
        }
        
        guard let publicKeyHash = createPublicKeyHash(publicKey: publicKey) else {
            return
        }
        
        guard let signature = signMessage(privateKey: privateKey) else {
            return
        }
        
        self.privateKey = privateKey.base64String()
        self.publicKey = publicKey.base64String()
        self.publicKeyHash = publicKeyHash.base64String()
        self.signature = signature.base64String()
    }
    
    func createPrivateKey(seed: Data) -> ZKPrivateKey? {
        switch ZKSyncSDK.generatePrivateKey(seed: seed) {
        case .success(let result):
            return result

        case .failure(let error):
            let _ = Alert(title: Text(error.localizedDescription))
            return nil
        }
    }
    
    func createPublicKey(privateKey: ZKPrivateKey) -> ZKPackedPublicKey? {
        switch ZKSyncSDK.getPublicKey(privateKey: privateKey) {
        case .success(let result):
            return result
            
        case .failure(let error):
            let _ = Alert(title: Text(error.localizedDescription))
            return nil
        }
    }
    
    func createPublicKeyHash(publicKey: ZKPackedPublicKey) -> ZKPublicHash? {
        switch ZKSyncSDK.getPublicKeyHash(publicKey: publicKey) {
        case .success(let result):
            return result
            
        case .failure(let error):
            let _ = Alert(title: Text(error.localizedDescription))
            return nil
        }
    }
    
    func signMessage(privateKey: ZKPrivateKey) -> ZKSignature? {
        switch ZKSyncSDK.signMessage(privateKey: privateKey, message: self.message) {
        case .success(let result):
            return result
            
        case .failure(let error):
            let _ = Alert(title: Text(error.localizedDescription))
            return nil
        }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Message")
                TextField("Message", text: $viewModel.message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Seed")
                TextField("Seed", text: $viewModel.seedText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("Private Key")
                TextField("Private Key", text: $viewModel.privateKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Public Key")
                TextField("Public Key", text: $viewModel.publicKey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Public Key Hash")
                TextField("Public Key Hash", text: $viewModel.publicKeyHash)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Signature")
                TextField("Signature", text: $viewModel.signature)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }
            
            Button("Update", action: viewModel.setNeedsToUpdate)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
