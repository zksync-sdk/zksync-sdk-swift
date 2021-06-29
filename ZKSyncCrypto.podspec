Pod::Spec.new do |spec|

  spec.name         = "ZKSyncCrypto"
  spec.version      = "0.0.9"
  spec.summary      = "Cryptographical primitives used in zkSync network."

  spec.description  = <<-DESC
  zkSync is a scaling and privacy engine for Ethereum. Its current functionality scope includes low gas transfers of ETH and ERC20 tokens in the Ethereum network
                   DESC

  spec.homepage     = "https://github.com/zksync-sdk/zksync-sdk-swift"
  spec.license      = "MIT"

  spec.author       = { "The Matter Labs team" => "hello@matterlabs.dev" }

  spec.platform     = :ios, "10.0"

  #  When using multiple platforms
  spec.ios.deployment_target = "10.0"
  spec.swift_version = '5.0'

  spec.source       = { :git => "https://github.com/zksync-sdk/zksync-sdk-swift.git", :tag => "#{spec.version}" }

  spec.source_files = "ZKSyncCrypto/ZKSyncCrypto/**/*.{swift,h}"
  spec.preserve_paths = 'ZKSyncCrypto/ZKSyncCrypto/*.{modulemap}'
  spec.vendored_libraries = "ZKSyncCrypto/ZKSyncCrypto/libzks/*.{a}"

  # spec.xcconfig = { :VALID_ARCHS => 'arm64 arm64e armv7 armv7s x86_64' }
  spec.pod_target_xcconfig = { :VALID_ARCHS => 'arm64 arm64e armv7 armv7s x86_64' }
  # spec.user_target_xcconfig = { :VALID_ARCHS => 'arm64 arm64e armv7 armv7s x86_64' }

end
